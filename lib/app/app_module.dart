import 'package:dio/dio.dart';
import 'package:easydrink/app/core/const/app_routers.dart';
import 'package:easydrink/app/interfaces/drink_repository_interface.dart';
import 'package:easydrink/app/modules/tabs/tabs_module.dart';
import 'package:easydrink/app/repositories/drink_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_bootstrap.dart';
import 'app_controller.dart';
import 'core/api/api.dart';
import 'core/const/app_config.dart';
import 'interfaces/favorite_repository_interface.dart';
import 'modules/drink_detail/drink_detail_modules.dart';
import 'modules/favorite/favorite_controller.dart';
import 'modules/search/search_controller.dart';
import 'repositories/favorite_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Api(i<BaseOptions>())),
        Bind(
          (i) => BaseOptions(
            baseUrl: AppConfig.apiBaseUrl,
            connectTimeout: 10000,
          ),
        ),
        Bind((i) => AppController()),
        Bind<IDrinkRepository>((i) => DrinkRepository()),
        Bind<IFavoriteRepository>((i) => FavoriteRepository()),
        Bind(
          (i) => SearchController(),
        ),
        Bind(
          (i) => FavoriteController(),
        ),
      ];

  @override
  Widget get bootstrap => AppBootstrap();

  @override
  List<ModularRouter> get routers => [
        ModularRouter(AppRouters.tabs, module: TabsModule()),
        ModularRouter(AppRouters.drinkDetail, module: DrinkDetailModule()),
      ];
}
