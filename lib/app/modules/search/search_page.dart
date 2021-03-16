import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/core/util/list_callbacks.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:easydrink/app/modules/search/enums/filter_enum.dart';
import 'package:easydrink/app/modules/search/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'search_controller.dart';
import '../../widgets/drink_card.dart';
import 'widgets/header.dart';

class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchController> {
  @override
  void initState() {
    controller.listCtrl.addPageRequestListener((pageKey) {
      controller.fetchList(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 60,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                              color: Colors.white,
                              height: 470,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 12),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Icon(Feather.filter,
                                                color: AppColors.primary),
                                          ),
                                          Text(
                                            Translate(context).text("findBy"),
                                            style: TextStyle(
                                                color: AppColors.sweetBlack,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 26),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RadioListTile<FilterEnum>(
                                      title: Text(Translate(context)
                                          .text("filter.name")),
                                      value: FilterEnum.name,
                                      groupValue: controller.filterEnum,
                                      onChanged: (FilterEnum value) =>
                                          controller.changeFilter(
                                              value, context),
                                    ),
                                    RadioListTile<FilterEnum>(
                                      title: Text(Translate(context)
                                          .text("filter.category")),
                                      value: FilterEnum.category,
                                      groupValue: controller.filterEnum,
                                      onChanged: (FilterEnum value) =>
                                          controller.changeFilter(
                                              value, context),
                                    ),
                                    RadioListTile<FilterEnum>(
                                      title: Text(Translate(context)
                                          .text("filter.glassType")),
                                      value: FilterEnum.glassType,
                                      groupValue: controller.filterEnum,
                                      onChanged: (FilterEnum value) =>
                                          controller.changeFilter(
                                              value, context),
                                    ),
                                    RadioListTile<FilterEnum>(
                                      title: Text(Translate(context)
                                          .text("filter.ingredient")),
                                      value: FilterEnum.ingredient,
                                      groupValue: controller.filterEnum,
                                      onChanged: (FilterEnum value) =>
                                          controller.changeFilter(
                                              value, context),
                                    ),
                                    RadioListTile<FilterEnum>(
                                      title: Text(Translate(context)
                                          .text("filter.drinkType")),
                                      value: FilterEnum.drinkType,
                                      groupValue: controller.filterEnum,
                                      onChanged: (FilterEnum value) =>
                                          controller.changeFilter(
                                              value, context),
                                    ),
                                  ]),
                            ));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SearchBar(
                  focusNode: controller.focusNode,
                  onSearch: (term) {
                    controller.callSearch(term);
                  },
                  controller: controller.textBarController,
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 260,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AnimationLimiter(
                      child: PagedListView<int, Drink>(
                        scrollDirection: Axis.horizontal,
                        pagingController: controller.listCtrl,
                        cacheExtent: 1000,
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 12, bottom: 20),
                        builderDelegate: PagedChildBuilderDelegate<Drink>(
                          noItemsFoundIndicatorBuilder: (_) {
                            return ListCallbacks.noItemsFoundIndicator(context);
                          },
                          firstPageErrorIndicatorBuilder: (_) {
                            return ListCallbacks.firstLoadError(context,
                                onTryAgain: () {
                              controller.listCtrl.refresh();
                            });
                          },
                          itemBuilder: (context, item, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: Container(
                                child: DrinkCard(
                                  appController: controller.appController,
                                  drink: item,
                                ),
                              ))),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
