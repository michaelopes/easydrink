import 'package:easydrink/app/core/const/app_routers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'tabs_controller.dart';
import 'tabs_page.dart';

class TabsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => TabsController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          AppRouters.tabs,
          child: (_, args) => TabsPage(),
        ),
      ];

  static Inject get to => Inject<TabsModule>.of();
}
