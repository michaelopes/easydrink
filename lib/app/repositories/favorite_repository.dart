import 'dart:convert';

import 'package:easydrink/app/core/local_storage/local_storage.dart';
import 'package:easydrink/app/core/response/response_builder.dart';
import 'package:easydrink/app/core/response/response_default.dart';
import 'package:easydrink/app/interfaces/favorite_repository_interface.dart';
import 'package:easydrink/app/models/drink.dart';

class FavoriteRepository implements IFavoriteRepository {
  @override
  Future<List<Drink>> getListFavorite() async {
    try {
      var localStorage = await LocalStorage.setInstance();
      var stringList = localStorage.getString("favoritev2");
      if (stringList != null && stringList.isNotEmpty) {
        var jList = json.decode(stringList);
        var drinks = new List<Drink>();
        jList.forEach((v) {
          drinks.add(Drink.fromJson(v));
          drinks.sort((a, b) => a.strDrink.compareTo(b.strDrink));
        });
        return drinks;
      } else {
        return <Drink>[];
      }
    } catch (e) {
      return <Drink>[];
    }
  }

  Future<bool> addListFavorite(List<Drink> list) async {
    try {
      var localStorage = await LocalStorage.setInstance();
      var sList = json.encode(list);
      localStorage.setString("favoritev2", sList);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ResponseDefault> addFavorite(Drink drink) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      var list = await getListFavorite();
      drink.isFavorite = true;
      list.add(drink);
      addListFavorite(list);
      return ResponseBuilder.success();
    } catch (e) {
      return ResponseBuilder.failed();
    }
  }

  @override
  Future<ResponseDefault> removeFavorite(Drink drink) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      var list = await getListFavorite();
      List<Drink> newList =
          list.where((i) => i.idDrink != drink.idDrink).toList();
      await addListFavorite(newList);
      return ResponseBuilder.success();
    } catch (e) {
      return ResponseBuilder.failed();
    }
  }
}
