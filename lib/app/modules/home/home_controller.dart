import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/response/response_default.dart';
import 'package:easydrink/app/interfaces/drink_repository_interface.dart';
import 'package:easydrink/app/models/category.dart';
import 'package:easydrink/app/modules/search/search_controller.dart';
import 'package:easydrink/app/modules/tabs/tabs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PagingController<int, Category> listCtrl =
      PagingController(firstPageKey: 0);

  @observable
  int filterActiveIndex = 0;

  @action
  void setFilterActiveIndex(int index) {
    filterActiveIndex = index;
    listCtrl.refresh();
  }

  Color getColorByActiveIndex() {
    switch (filterActiveIndex) {
      case 0:
        return AppColors.sweetOrange;
        break;
      case 1:
        return AppColors.vine;
        break;
      case 2:
        return AppColors.yellow;
        break;
      case 3:
        return AppColors.sweetBlue;
        break;
      default:
        return AppColors.sweetOrange;
    }
  }

  String getSearchPrefix() {
    switch (filterActiveIndex) {
      case 0:
        return "c";
        break;
      case 1:
        return "i";
        break;
      case 2:
        return "g";
        break;
      case 3:
        return "a";
        break;
      default:
        return "c";
    }
  }

  void redirectToSearch(Category category) {
    var tbsCntrl = Modular.get<TabsController>();
    var searchCntrl = Modular.get<SearchController>();
    tbsCntrl.tabController.changeModule(1);
    var prefix = getSearchPrefix();
    searchCntrl.callSearch("$prefix:${category.description}");
  }

  Future<void> fetchList(int pageKey) async {
    try {
      final newItems = await listCategories();
      listCtrl.appendLastPage(newItems);
      //int.parse("A");
    } catch (error) {
      listCtrl.error = error;
    }
  }

  Future<List<Category>> listCategories() async {
    var repo = Modular.get<IDrinkRepository>();

    ResponseDefault resp;
    switch (filterActiveIndex) {
      case 0:
        resp = await repo.listCategories();
        break;
      case 1:
        resp = await repo.listIngredients();
        break;
      case 2:
        resp = await repo.listGlasses();
        break;
      case 3:
        resp = await repo.listDrinkType();
        break;
    }

    if (resp.success) {
      return resp.object;
    } else {
      return <Category>[];
    }
  }
}
