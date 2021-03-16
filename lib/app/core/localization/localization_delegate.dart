import 'package:flutter/material.dart';

import 'localization.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['pt', 'en'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    var localizations = Localization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
