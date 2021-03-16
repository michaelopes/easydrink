import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'core/theme/app_theme_factory.dart';
import 'interfaces/app_theme_interface.dart';
import 'interfaces/favorite_repository_interface.dart';
import 'models/drink.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  IAppThemeInterface themeApp = AppThemeFactory.getTheme(ThemeMode.light);

  @observable
  ThemeMode themeMode = ThemeMode.light;

  @observable
  Map<int, bool> favoritedDrink = {0: false};

  @observable
  Map<int, double> ratingDrink = {0: 0};

  @action
  void setFavoriteDrink(Map<int, bool> favoriteDrink) {
    this.favoritedDrink = favoriteDrink;
  }

  @action
  void setRatingDrink(Map<int, double> rating) {
    this.ratingDrink = rating;
  }

  void checkFavoritedDrink(Drink drink) {
    var fDrink = favoritedDrink.entries.first;
    if (fDrink.key != 0 &&
        drink.idDrink == fDrink.key &&
        fDrink.value != drink.isFavorite) {
      drink.isFavorite = fDrink.value;
    }
  }

  void checkRatingDrink(Drink drink) {
    var fDrink = ratingDrink.entries.first;
    if (fDrink.key != 0 && drink.idDrink == fDrink.key) {
      drink.setUserStar(fDrink.value);
    }
  }

  Future<void> submitRatingDrink(int idDrink, double star) async {
    await Future.delayed(const Duration(seconds: 2));
    setRatingDrink({idDrink: star});
  }

  Future<void> favoriteDrink(Drink drink) async {
    var repo = Modular.get<IFavoriteRepository>();
    try {
      if (drink.isFavorite) {
        await repo.removeFavorite(drink);
        setFavoriteDrink({drink.idDrink: false});
      } else {
        await repo.addFavorite(drink);
        setFavoriteDrink({drink.idDrink: true});
      }
    } catch (e) {
      setFavoriteDrink({drink.idDrink: drink.isFavorite});
    }
  }
}
