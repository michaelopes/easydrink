import 'package:cached_network_image/cached_network_image.dart';
import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/core/util/star_rating.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:easydrink/app/modules/favorite/favorite_controller.dart';
import 'package:easydrink/app/widgets/app_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../app_controller.dart';
import 'drink_detail_controller.dart';
import 'widgets/ingredient_item.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;

  const DrinkDetailPage({Key key, this.drink}) : super(key: key);

  @override
  _DrinkDetailPageState createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState
    extends ModularState<DrinkDetailPage, DrinkDetailController> {
  @override
  void initState() {
    controller.appController = Modular.get<AppController>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildIngredients(Drink drink, BuildContext context) {
    var column = <Widget>[];
    var jsonDrink = drink.toJson();
    for (var i = 1; i < 16; i++) {
      var ingredient = jsonDrink["strIngredient$i"];
      var measure = jsonDrink["strMeasure$i"];
      if (ingredient != null && ingredient.isNotEmpty) {
        column.add(IndredientItem(
          ingredient: ingredient,
          measure: measure ?? "To your liking",
          controller: controller,
        ));
      }
    }

    return Column(children: column);
  }

  Widget _buildBody(Drink drink, BuildContext context) {
    return Observer(builder: (_) {
      controller.appController.checkRatingDrink(widget.drink);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(drink.strDrink,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: AppColors.sweetBlack)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder<String>(
                          future:
                              controller.getTranslatedText(drink.strAlcoholic),
                          builder: (context, snapshot) {
                            var text = "";
                            if (snapshot.hasData) {
                              text = snapshot.data;
                            } else {
                              text = drink.strAlcoholic;
                            }
                            return Text(text,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.pastelGrey));
                          }),
                    ],
                  ),
                ),
                Container(
                  width: 58,
                  height: 58,
                  child: InkWell(
                    onTap: () => StarRating.show((int rating) async {
                      var progress = AppProgressDialog(
                          context, Translate(context).text("waiting"));
                      await progress.show();
                      await controller.appController.submitRatingDrink(
                          widget.drink.idDrink, rating.toDouble());
                      await progress.hide();
                    }, context, "ratingDrink"),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.drink.rating.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          MaterialCommunityIcons.star,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primary.withOpacity(.5),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primary),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildIngredients(drink, context),
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translate(context).text("drinkDetail.preparationMode"),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.strongGrey,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder<String>(
                    future: controller.getTranslatedText(drink.strInstructions),
                    builder: (context, snapshot) {
                      var text = "";
                      if (snapshot.hasData) {
                        text = snapshot.data;
                      } else {
                        text = drink.strInstructions;
                      }
                      return Text(
                        text,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.pastelGrey,
                            fontSize: 14),
                      );
                    }),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _panelBuild(ScrollController sc) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: SingleChildScrollView(
          controller: sc,
          child: FutureBuilder<Drink>(
            future: controller.getDrinkDetail(widget.drink.idDrink),
            builder: (BuildContext context, AsyncSnapshot<Drink> snapshot) {
              if (snapshot.hasData) {
                return _buildBody(snapshot.data, context);
              } else if (snapshot.hasError ||
                  (snapshot.hasData && snapshot.data == null)) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            Translate(context).text("drinkDetail.errorMsg"),
                            textAlign: TextAlign.center),
                      )
                    ]);
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 40,
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(Translate(context).text("waiting"),
                          textAlign: TextAlign.center),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
    );
  }

  Widget _panelBody() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    child: Center(
                      child: Icon(MaterialCommunityIcons.chevron_left,
                          color: AppColors.primary, size: 26),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.lightOrange, shape: BoxShape.circle),
                  ),
                ),
                Row(
                  children: [
                    Observer(builder: (context) {
                      controller.appController
                          .checkFavoritedDrink(widget.drink);
                      return InkWell(
                        onTap: () async {
                          var msg = widget.drink.isFavorite
                              ? Translate(context).text("removingFavorite")
                              : Translate(context).text("addingFavorite");
                          var progress = AppProgressDialog(context, msg);
                          await progress.show();
                          await controller.appController
                              .favoriteDrink(widget.drink);

                          if (widget.drink.isFavorite) {
                            var cntrl = Modular.get<FavoriteController>();
                            cntrl.listCtrl.refresh();
                          }
                          await progress.hide();
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          child: Center(
                            child: Icon(MaterialCommunityIcons.heart,
                                color: widget.drink.isFavorite
                                    ? AppColors.sweetRed
                                    : Colors.white,
                                size: 26),
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.lightOrange,
                              shape: BoxShape.circle),
                        ),
                      );
                    }),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () => controller.urlFileShare(context),
                      child: Container(
                        height: 44,
                        width: 44,
                        child: Center(
                          child: Icon(Feather.share_2,
                              color: AppColors.primary, size: 23),
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.lightOrange,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CachedNetworkImage(
                  width: 145,
                  imageUrl: widget.drink.strDrinkThumb,
                  imageBuilder: (context, imageProvider) => Container(
                      height: 145,
                      width: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.sweetGrey,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover))),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 12),
            child: InkWell(
              onTap: () {
                if (controller.langCode == "en") {
                  Locale myLocale = Localizations.localeOf(context);
                  controller.setLangCode(myLocale.languageCode);
                } else {
                  controller.setLangCode("en");
                }
              },
              child: Observer(builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(MaterialCommunityIcons.google_translate,
                          color: AppColors.strongGrey),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translate(context).text(
                              controller.langCode == "en"
                                  ? "drinkDetail.originalText"
                                  : "drinkDetail.translatedTo",
                              params: {
                                "lang": controller.langCode.toUpperCase()
                              }),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.pastelGrey,
                              fontSize: 12),
                        ),
                        Text(
                          Translate(context).text(controller.langCode == "pt"
                              ? "drinkDetail.showOriginal"
                              : "drinkDetail.showTranslated"),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.strongGrey,
                              fontSize: 11),
                        )
                      ],
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SlidingUpPanel(
        backdropColor: Colors.transparent,
        boxShadow: [],
        minHeight: height - 320,
        maxHeight: height - 120,
        onPanelClosed: () {
          controller.setIsPanelOpen(false);
        },
        onPanelOpened: () {
          controller.setIsPanelOpen(true);
        },
        header: Container(
          height: 30,
          padding: EdgeInsets.only(top: 6),
          width: width,
          child: Observer(builder: (_) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  !controller.isPanelOpen
                      ? MaterialCommunityIcons.chevron_up
                      : MaterialCommunityIcons.chevron_down,
                  color: AppColors.pastelGrey,
                  size: 22,
                )
              ],
            );
          }),
        ),
        panelBuilder: (ScrollController sc) => _panelBuild(sc),
        body: _panelBody(),
      ),
    );
  }
}
