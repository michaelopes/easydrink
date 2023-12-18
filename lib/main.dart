import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';

void main() {
  int.parse("b");
  runApp(ModularApp(
    module: AppModule(),
  ));
}
