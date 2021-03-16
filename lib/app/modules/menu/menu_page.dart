import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/core/util/star_rating.dart';
import 'package:easydrink/app/modules/menu/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info/package_info.dart';

import 'menu_controller.dart';

class MenuPage extends StatefulWidget {
  MenuPage();

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends ModularState<MenuPage, MenuController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar",
                  style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Translate(context).text("menu.title"),
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.sweetBlack)),
                SizedBox(
                  height: 10,
                ),
                Text(Translate(context).text("menu.subtitle"),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.subtitleGrey))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MenuItem(
              onPressed: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                String appName = packageInfo.appName;
                String version = packageInfo.version;
                String buildNumber = packageInfo.buildNumber;
                _showDialog("Sobre o $appName",
                    "Versão: $version\nNúmero da compilação: $buildNumber");
              },
              icon: MaterialCommunityIcons.information,
              translateKey: "menu.aboutThisApp",
            ),
            MenuItem(
              onPressed: () =>
                  _showDialog("Termos de uso", "Menu em construção"),
              icon: MaterialCommunityIcons.file_document,
              translateKey: "menu.useTerms",
            ),
            MenuItem(
              onPressed: () =>
                  _showDialog("Políticas de privacidade", "Menu em construção"),
              icon: MaterialCommunityIcons.lock,
              translateKey: "menu.privacyPolicy",
            ),
            MenuItem(
              onPressed: () => StarRating.show(
                  (int rating) {}, context, "ratingApp",
                  description: "Apenas uma demonstração de avaliação"),
              icon: MaterialCommunityIcons.star,
              translateKey: "menu.ratingThisApp",
            ),
          ],
        ),
      ),
    ));
  }
}
