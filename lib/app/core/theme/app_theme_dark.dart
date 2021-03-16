import 'package:easydrink/app/interfaces/app_theme_interface.dart';
import 'package:flutter/material.dart';

class AppThemeDark implements IAppThemeInterface {
  @override
  ThemeData getTheme() {
    return ThemeData.dark();
  }

  @override
  String themeToString() {
    return ThemeMode.dark.toString();
  }

  @override
  IAppThemeInterface setContext(BuildContext context) {
    return this;
  }
}
