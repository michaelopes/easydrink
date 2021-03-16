import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/modules/favorite/favorite_module.dart';
import 'package:easydrink/app/modules/home/home_module.dart';
import 'package:easydrink/app/modules/menu/menu_modules.dart';
import 'package:easydrink/app/modules/search/search_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'tabs_controller.dart';

class TabsPage extends StatefulWidget {
  TabsPage();

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends ModularState<TabsPage, TabsController>
    with SingleTickerProviderStateMixin {
  /*final iconList = <IconData>[Feather.search, Feather.home, Feather.menu];*/

  final iconList = <IconData>[
    Feather.home,
    Feather.search,
    MaterialCommunityIcons.heart,
    Feather.menu
  ];
  var modules = [HomeModule(), SearchModule(), FavoriteModule(), MenuModule()];

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  @override
  void initState() {
    controller.tabController.listen((value) {
      controller.setCurrentTabIndex(value);
    });

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: Observer(builder: (context) {
            return FloatingActionButton(
              elevation: 8,
              backgroundColor: Colors.white,
              child: Icon(FontAwesome.home,
                  size: 30,
                  color: controller.currentTabIndex == 0
                      ? AppColors.primary
                      : AppColors.bottomBarDisableIcon),
              onPressed: () {
                /*_animationController.reset();
                _animationController.forward();*/
                controller.tabController.changeModule(0);
              },
            );
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        bottomNavigationBar: Observer(builder: (context) {
          return AnimatedBottomNavigationBar.builder(
            height: 45,
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              var color =
                  isActive ? AppColors.primary : AppColors.bottomBarDisableIcon;
              return index == 0
                  ? SizedBox(width: 50)
                  : Icon(
                      iconList[index],
                      size: 27,
                      color: color,
                    );
            },
            gapWidth: 12,
            elevation: 1,
            backgroundColor: Colors.white,
            activeIndex: controller.currentTabIndex,
            splashColor: Colors.white,
            notchAndCornersAnimation: animation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            notchMargin: 6,
            gapLocation: GapLocation.end,
            //leftCornerRadius: 28,
            //rightCornerRadius: 28,
            onTap: (index) => controller.tabController.changeModule(index),
          );
        }),
        body: RouterOutletList(
            modules: modules, controller: controller.tabController));
  }
}
