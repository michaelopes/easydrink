import 'package:easydrink/app/interfaces/favorite_repository_interface.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';
part 'favorite_controller.g.dart';

class FavoriteController = _FavoriteControllerBase with _$FavoriteController;

abstract class _FavoriteControllerBase with Store {
  final PagingController<int, Drink> listCtrl =
      PagingController(firstPageKey: 0);

  final AppController appController = Modular.get<AppController>();

  Future<void> fetchList(int pageKey) async {
    try {
      var repo = Modular.get<IFavoriteRepository>();
      final newItems = await repo.getListFavorite();
      listCtrl.appendLastPage(newItems);
    } catch (error) {
      listCtrl.error = error;
    }
  }
}
