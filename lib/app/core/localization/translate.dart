import 'package:flutter/material.dart';

import 'localization.dart';

class Translate {
  final BuildContext context;

  Translate(this.context);

  String text(String key,
      {Map<String, String> params, String defaultValue = ''}) {
    return Localization.of(context)
        .translate(key, params: params, defaultValue: defaultValue);
  } 
}
