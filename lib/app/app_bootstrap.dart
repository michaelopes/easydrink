import 'package:easydrink/app/core/const/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'core/localization/localization.dart';

class AppBootstrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppController appController = Modular.get<AppController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyDrink',
      initialRoute: AppRouters.tabs,
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      theme: appController.themeApp.setContext(context).getTheme(),
      themeMode: Modular.get<AppController>().themeMode,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        Localization.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
