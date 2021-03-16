import 'package:easydrink/app/core/response/response_default.dart';
import 'package:easydrink/app/interfaces/drink_repository_interface.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:easydrink/app/modules/search/enums/filter_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';
part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final PagingController<int, Drink> listCtrl =
      PagingController(firstPageKey: 0);

  final AppController appController = Modular.get<AppController>();

  final TextEditingController textBarController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @observable
  FilterEnum filterEnum = FilterEnum.name;

  String searchPrefix = "";
  String searchTerm = "";

  @action
  void setFilterEnum(FilterEnum filter) {
    filterEnum = filter;
  }

  Future<void> fetchList(int pageKey) async {
    try {
      final newItems = await search();
      listCtrl.appendLastPage(newItems);
      //int.parse("A");
    } catch (error) {
      listCtrl.error = error;
    }
  }

  Future<List<Drink>> search() async {
    if (searchPrefix.isNotEmpty && searchTerm.isNotEmpty) {
      var repo = Modular.get<IDrinkRepository>();
      ResponseDefault resp = await repo.searchDrink(searchPrefix, searchTerm);
      if (resp.success) {
        return resp.object;
      } else {
        return <Drink>[];
      }
    } else {
      return <Drink>[];
    }
  }

  void setConvertedSearchPrefixToFilterEnum(String prefix) {
    switch (prefix) {
      case 's':
        setFilterEnum(FilterEnum.name);
        break;
      case 'c':
        setFilterEnum(FilterEnum.category);
        break;
      case 'g':
        setFilterEnum(FilterEnum.glassType);
        break;
      case 'i':
        setFilterEnum(FilterEnum.ingredient);
        break;
      case 'a':
        setFilterEnum(FilterEnum.drinkType);
        break;
    }
  }

  void changeFilter(FilterEnum filter, BuildContext context) {
    Navigator.of(context).popUntil((route) => route.settings.name == '/');
    var text = textBarController.text;
    if (text.trim().isNotEmpty) {
      textBarController.text = convertTextInSearchTerm(text, filter);
      setFilterEnum(filter);
      callSearch(textBarController.text);
    }
  }

  String convertTextInSearchTerm(String text, FilterEnum filter) {
    var arr;
    if (text.contains(":")) {
      arr = text.split(":");
    } else {
      arr = <String>["", text];
    }
    switch (filter) {
      case FilterEnum.name:
        return "s:${arr[1]}";
        break;
      case FilterEnum.category:
        return "c:${arr[1]}";
        break;
      case FilterEnum.glassType:
        return "g:${arr[1]}";
        break;
      case FilterEnum.ingredient:
        return "i:${arr[1]}";
        break;
      case FilterEnum.drinkType:
        return "a:${arr[1]}";
        break;
      default:
        return "";
    }
  }

  void callSearch(String text) {
    var arr = text.split(":");
    if (arr.length > 1) {
      if (arr[0] == "s") {
        searchPrefix = "search.php?s";
      } else {
        searchPrefix = "filter.php?${arr[0]}";
      }
      searchTerm = arr[1].replaceAll(" ", "_");
      setConvertedSearchPrefixToFilterEnum(arr[0]);
    } else {
      var term = convertTextInSearchTerm(text, filterEnum);
      if (term.isNotEmpty && term.contains(":")) {
        callSearch(term);
      }
      return;
    }

    textBarController.text = text;
    listCtrl.refresh();
  }
}
