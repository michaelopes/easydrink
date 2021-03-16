import 'package:flutter/material.dart';

abstract class IAppThemeInterface {
  IAppThemeInterface setContext(BuildContext context);
  ThemeData getTheme();
  String themeToString();
}
