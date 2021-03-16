import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easydrink/app/app_controller.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/interfaces/drink_repository_interface.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:easydrink/app/widgets/app_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:translator/translator.dart';
import 'package:share/share.dart';
part 'drink_detail_controller.g.dart';

class DrinkDetailController = _DrinkDetailControllerBase
    with _$DrinkDetailController;

abstract class _DrinkDetailControllerBase with Store {
  AppController appController;

  Drink _apiCachedDrink;

  @observable
  String langCode = "en";

  @observable
  bool isPanelOpen = false;

  @action
  void setIsPanelOpen(bool status) {
    isPanelOpen = status;
  }

  @action
  void setLangCode(String code) {
    langCode = code;
  }

  Future<String> getTranslatedText(String text) async {
    if (langCode == "en") {
      return Future.value(text);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      final translator = GoogleTranslator();
      var translation = await translator.translate(text, to: langCode);
      return translation.text;
    }
  }

  Future<Drink> getDrinkDetail(int idDrink) async {
    if (_apiCachedDrink == null) {
      var repo = Modular.get<IDrinkRepository>();
      var res = await repo.getDrinkDetail(idDrink);
      _apiCachedDrink = res.object;
      return res.object;
    } else {
      return _apiCachedDrink;
    }
  }

  Future<void> urlFileShare(BuildContext context) async {
    if (_apiCachedDrink != null) {
      var progress =
          AppProgressDialog(context, Translate(context).text("waiting"));
      await progress.show();
      final RenderBox box = context.findRenderObject();
      var lstText = <String>[];
      lstText.add(
          "COMO FAZER DRINK - ${_apiCachedDrink.strDrink.toUpperCase()}\n");
      lstText.add("INGREDIENTES:");
      lstText.addAll(_listIngredients());
      lstText.add("\nMODO DE PREPARO");
      lstText.add(_apiCachedDrink.strInstructions);
      lstText.add(
          "\nPara mais receitas como essa BAIXE GRÁTIS o EasyDrink na loja de aplicativos");

      if (Platform.isAndroid) {
        try {
          var url = _apiCachedDrink.strDrinkThumb;
          var response = await Dio().get(
            url,
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                validateStatus: (status) {
                  return status < 500;
                }),
          );
          final documentDirectory = (await getExternalStorageDirectory()).path;
          //var b = response.data.bodyBytes;
          File imgFile = new File('$documentDirectory/flutter.jpg');
          imgFile.writeAsBytesSync(response.data);

          List<String> imagePaths = ['$documentDirectory/flutter.jpg'];

          await progress.hide();
          await Share.shareFiles(imagePaths,
              subject:
                  "COMO FAZER DRINK - ${_apiCachedDrink.strDrink.toUpperCase()}",
              text: lstText.join("\n"),
              mimeTypes: ["image/png"],
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        } catch (e) {
          print(e);
        }
      } else {
        Share.share(lstText.join("\n"),
            subject:
                "COMO FAZER DRINK - ${_apiCachedDrink.strDrink.toUpperCase()}",
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }
    }
  }

  List<String> _listIngredients() {
    var arr = <String>[];
    var jsonDrink = _apiCachedDrink.toJson();
    for (var i = 1; i < 16; i++) {
      var ingredient = jsonDrink["strIngredient$i"];
      var measure = jsonDrink["strMeasure$i"];
      if (ingredient != null && ingredient.isNotEmpty) {
        arr.add("Nome: $ingredient | Qtde: ${measure ?? "To your liking"}");
      }
    }
    return arr;
  }
}
