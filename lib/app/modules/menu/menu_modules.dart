import 'package:flutter_modular/flutter_modular.dart';
import 'menu_controller.dart';
import 'menu_page.dart';

class MenuModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => MenuController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => MenuPage(),
        ),
      ];

  static Inject get to => Inject<MenuModule>.of();
}
