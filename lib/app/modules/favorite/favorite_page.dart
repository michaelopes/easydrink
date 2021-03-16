import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/core/util/list_callbacks.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:easydrink/app/widgets/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'favorite_controller.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage();

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState
    extends ModularState<FavoritePage, FavoriteController> {
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
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Translate(context).text("favorite.title"),
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.sweetBlack)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(Translate(context).text("favorite.subtitle"),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.subtitleGrey))
                  ],
                ),
                SizedBox(
                  height: 30,
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
                                  onFavoriteRemove: () {
                                    controller.listCtrl.refresh();
                                  },
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
