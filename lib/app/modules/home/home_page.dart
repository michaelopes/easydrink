import 'package:carousel_slider/carousel_slider.dart';
import 'package:easydrink/app/core/const/app_assets.dart';
import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/core/util/list_callbacks.dart';
import 'package:easydrink/app/models/category.dart';
import 'package:easydrink/app/modules/home/widgets/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'home_controller.dart';
import 'widgets/list_item.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    controller.listCtrl.addPageRequestListener((pageKey) {
      controller.fetchList(pageKey);
    });
    super.initState();
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    controller.setFilterActiveIndex(index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -70,
            top: -40,
            child: Container(
              width: MediaQuery.of(context).size.width + 100,
              height: 290,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(260))),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppAssets.logoWhite,
                      width: 140,
                    ),
                    /*Icon(MaterialCommunityIcons.dots_vertical,
                        size: 24, color: AppColors.primary),*/
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 8),
                child: Text(Translate(context).text("fastFilters"),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 26)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*  Text(Translate(context).text("fastFilters"),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.sweetBlack)),*/
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Observer(builder: (context) {
                        return CarouselSlider(
                          options: CarouselOptions(
                              initialPage: controller.filterActiveIndex,
                              autoPlay: false,
                              aspectRatio: 2.15,
                              enlargeCenterPage: true,
                              onPageChanged: onPageChange,
                              viewportFraction: .4),
                          items: [
                            FilterItem(
                              iconAsset: AppAssets.categoryThumb,
                              translateKey: "categories",
                              isActive: controller.filterActiveIndex == 0,
                            ),
                            FilterItem(
                              iconAsset: AppAssets.ingredientsThumb,
                              translateKey: "ingredients",
                              isActive: controller.filterActiveIndex == 1,
                            ),
                            FilterItem(
                              iconAsset: AppAssets.glassTypeThumb,
                              translateKey: "glassTypes",
                              isActive: controller.filterActiveIndex == 2,
                            ),
                            FilterItem(
                              iconAsset: AppAssets.drinkTypeThumb,
                              translateKey: "drinkTypes",
                              isActive: controller.filterActiveIndex == 3,
                            )
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
              Expanded(
                child: PagedListView<int, Category>(
                  scrollDirection: Axis.vertical,
                  pagingController: controller.listCtrl,
                  cacheExtent: 1000,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 4, bottom: 70),
                  builderDelegate: PagedChildBuilderDelegate<Category>(
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
                      return ListItem(
                        circleColor: controller.getColorByActiveIndex(),
                        category: item,
                        onPressed: (category) {
                          controller.redirectToSearch(category);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
