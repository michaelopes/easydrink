import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/interfaces/app_theme_interface.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeLight implements IAppThemeInterface {
  BuildContext _context;

  @override
  IAppThemeInterface setContext(BuildContext context) {
    _context = context;
    return this;
  }

  @override
  ThemeData getTheme() {
    return ThemeData(
      accentColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bg,
      primaryColor: AppColors.primary,
      buttonColor: AppColors.primary,
      indicatorColor: AppColors.primary,
      primaryIconTheme: IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.rubikTextTheme(
        Theme.of(_context).textTheme,
      ),
    );
  }

  @override
  String themeToString() {
    return ThemeMode.light.toString();
  }
}
