// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$themeAppAtom = Atom(name: '_AppControllerBase.themeApp');

  @override
  IAppThemeInterface get themeApp {
    _$themeAppAtom.reportRead();
    return super.themeApp;
  }

  @override
  set themeApp(IAppThemeInterface value) {
    _$themeAppAtom.reportWrite(value, super.themeApp, () {
      super.themeApp = value;
    });
  }

  final _$themeModeAtom = Atom(name: '_AppControllerBase.themeMode');

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  final _$favoritedDrinkAtom = Atom(name: '_AppControllerBase.favoritedDrink');

  @override
  Map<int, bool> get favoritedDrink {
    _$favoritedDrinkAtom.reportRead();
    return super.favoritedDrink;
  }

  @override
  set favoritedDrink(Map<int, bool> value) {
    _$favoritedDrinkAtom.reportWrite(value, super.favoritedDrink, () {
      super.favoritedDrink = value;
    });
  }

  final _$ratingDrinkAtom = Atom(name: '_AppControllerBase.ratingDrink');

  @override
  Map<int, double> get ratingDrink {
    _$ratingDrinkAtom.reportRead();
    return super.ratingDrink;
  }

  @override
  set ratingDrink(Map<int, double> value) {
    _$ratingDrinkAtom.reportWrite(value, super.ratingDrink, () {
      super.ratingDrink = value;
    });
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  void setFavoriteDrink(Map<int, bool> favoriteDrink) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.setFavoriteDrink');
    try {
      return super.setFavoriteDrink(favoriteDrink);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRatingDrink(Map<int, double> rating) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.setRatingDrink');
    try {
      return super.setRatingDrink(rating);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeApp: ${themeApp},
themeMode: ${themeMode},
favoritedDrink: ${favoritedDrink},
ratingDrink: ${ratingDrink}
    ''';
  }
}
