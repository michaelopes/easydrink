import 'package:dio/native_imp.dart';
import 'package:easydrink/app/core/response/response_builder.dart';
import 'package:easydrink/app/core/response/response_default.dart';
import 'package:easydrink/app/interfaces/drink_repository_interface.dart';
import 'package:easydrink/app/interfaces/favorite_repository_interface.dart';
import 'package:easydrink/app/models/category.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrinkRepository implements IDrinkRepository {
  @override
  Future<ResponseDefault> listCategories() async {
    try {
      var api = Modular.get<DioForNative>();
      var resp = await api.get("/list.php?c=list");

      var jList = resp.data["drinks"];
      var catedories = new List<Category>();

      if (jList != null) {
        jList.forEach((v) {
          catedories.add(Category(description: v["strCategory"]));
        });
        catedories.sort((a, b) => a.description.compareTo(b.description));
      }
      return ResponseBuilder.success<List<Category>>(object: catedories);
    } catch (err) {
      return ResponseBuilder.failed(object: err.response);
    }
  }

  @override
  Future<ResponseDefault> listDrinkType() async {
    try {
      var api = Modular.get<DioForNative>();
      var resp = await api.get("/list.php?a=list");

      var jList = resp.data["drinks"];
      var catedories = new List<Category>();

      if (jList != null) {
        jList.forEach((v) {
          catedories.add(Category(description: v["strAlcoholic"]));
        });
        catedories.sort((a, b) => a.description.compareTo(b.description));
      }
      return ResponseBuilder.success<List<Category>>(object: catedories);
    } catch (err) {
      return ResponseBuilder.failed(object: err.response);
    }
  }

  @override
  Future<ResponseDefault> listGlasses() async {
    try {
      var api = Modular.get<DioForNative>();
      var resp = await api.get("/list.php?g=list");

      var jList = resp.data["drinks"];
      var catedories = new List<Category>();

      if (jList != null) {
        jList.forEach((v) {
          if (v["strGlass"].trim().isNotEmpty) {
            catedories.add(Category(description: v["strGlass"]));
          }
          catedories.sort((a, b) => a.description.compareTo(b.description));
        });
      }
      return ResponseBuilder.success<List<Category>>(object: catedories);
    } catch (err) {
      return ResponseBuilder.failed(object: err.response);
    }
  }

  @override
  Future<ResponseDefault> listIngredients() async {
    try {
      var api = Modular.get<DioForNative>();
      var resp = await api.get("/list.php?i=list");

      var jList = resp.data["drinks"];
      var catedories = new List<Category>();

      if (jList != null) {
        jList.forEach((v) {
          catedories.add(Category(description: v["strIngredient1"]));
        });
        catedories.sort((a, b) => a.description.compareTo(b.description));
      }
      return ResponseBuilder.success<List<Category>>(object: catedories);
    } catch (err) {
      return ResponseBuilder.failed(object: err.response);
    }
  }

  @override
  Future<ResponseDefault> searchDrink(String prefix, String term) async {
    try {
      var api = Modular.get<DioForNative>();
      var repo = Modular.get<IFavoriteRepository>();
      var favoriteList = await repo.getListFavorite();

      var resp = await api.get("/$prefix=$term");

      var jList = resp.data["drinks"];
      var drinks = new List<Drink>();

      if (jList != null) {
        jList.forEach((v) {
          if (v["strDrinkThumb"] != null &&
              v["strDrinkThumb"].trim().isNotEmpty) {
            var drink = Drink.fromJson(v);
            var lst = favoriteList.where((i) => i.idDrink == drink.idDrink);
            drink.isFavorite = lst.length > 0;
            drinks.add(drink);
          }
          drinks.sort((a, b) => a.strDrink.compareTo(b.strDrink));
        });
      }
      return ResponseBuilder.success<List<Drink>>(object: drinks);
    } catch (err) {
      return ResponseBuilder.failed(object: err.response);
    }
  }

  @override
  Future<ResponseDefault> getDrinkDetail(int idDrink) async {
    try {
      var api = Modular.get<DioForNative>();
      var repo = Modular.get<IFavoriteRepository>();
      var favoriteList = await repo.getListFavorite();

      var resp = await api.get("/lookup.php?i=$idDrink");

      var jList = resp.data["drinks"];

      if (jList != null && jList.length >= 1) {
        var drink = Drink.fromJson(jList[0]);
        var lst = favoriteList.where((i) => i.idDrink == drink.idDrink);
        drink.isFavorite = lst.length > 0;
        return ResponseBuilder.success<Drink>(object: drink);
      }
      return ResponseBuilder.success<Drink>(object: null);
    } catch (err) {
      return ResponseBuilder.failed(object: err.response);
    }
  }
}
