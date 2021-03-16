import 'package:easydrink/app/modules/favorite/favorite_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'tabs_controller.g.dart';

class TabsController = _TabsControllerBase with _$TabsController;

abstract class _TabsControllerBase with Store {
  final RouterOutletListController tabController = RouterOutletListController();

  @observable
  int currentTabIndex = 0;

  @action
  void setCurrentTabIndex(int index) {
    currentTabIndex = index;

    if (index == 2) {
      var cntrl = Modular.get<FavoriteController>();
      cntrl.listCtrl.refresh();
    }
  }
}
