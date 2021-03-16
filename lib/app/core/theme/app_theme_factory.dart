import 'package:easydrink/app/interfaces/app_theme_interface.dart';
import 'package:flutter/material.dart';

import 'app_theme_dark.dart';
import 'app_theme_light.dart';

class AppThemeFactory {
  static IAppThemeInterface getTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return AppThemeDark();
        break;
      case ThemeMode.light:
        return AppThemeLight();
        break;
      default:
        return AppThemeLight();
        break;
    }
  }
}
