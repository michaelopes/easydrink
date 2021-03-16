import 'package:easydrink/app/core/const/app_routers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'drink_detail_controller.dart';
import 'drink_detail_page.dart';

class DrinkDetailModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => DrinkDetailController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          AppRouters.drinkDetail,
          child: (_, args) => DrinkDetailPage(drink: args.data),
        ),
      ];

  static Inject get to => Inject<DrinkDetailModule>.of();
}
