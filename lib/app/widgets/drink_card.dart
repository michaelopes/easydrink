import 'package:cached_network_image/cached_network_image.dart';
import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/const/app_routers.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:easydrink/app/core/util/star_rating.dart';
import 'package:easydrink/app/models/drink.dart';
import 'package:easydrink/app/widgets/app_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app_controller.dart';

class DrinkCard extends StatelessWidget {
  final Drink drink;
  final AppController appController;
  final Function onFavoriteRemove;

  const DrinkCard(
      {Key key, this.drink, this.appController, this.onFavoriteRemove})
      : super(key: key);

  void _ratingDrink(BuildContext context) {
    StarRating.show((int rating) async {
      var progress =
          AppProgressDialog(context, Translate(context).text("waiting"));
      await progress.show();
      await appController.submitRatingDrink(drink.idDrink, rating.toDouble());
      await progress.hide();
    }, context, "ratingDrink");
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      appController.checkFavoritedDrink(drink);
      appController.checkRatingDrink(drink);

      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          child: InkWell(
            onTap: () {
              Modular.to.pushNamed(AppRouters.drinkDetail, arguments: drink);
            },
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, bottom: 125, top: 30),
                        child: CachedNetworkImage(
                          width: 100,
                          imageUrl: drink.strDrinkThumb,
                          imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.sweetGrey,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover))),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    drink.strDrink,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.strongGrey),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    InkWell(
                                      onTap: () => _ratingDrink(context),
                                      child: Icon(
                                        MaterialCommunityIcons.star,
                                        color: AppColors.primary,
                                        size: 28,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    InkWell(
                                      onTap: () => _ratingDrink(context),
                                      child: Text(
                                        drink.rating.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var msg = drink.isFavorite
                                            ? Translate(context)
                                                .text("removingFavorite")
                                            : Translate(context)
                                                .text("addingFavorite");
                                        var progress =
                                            AppProgressDialog(context, msg);
                                        await progress.show();
                                        await appController
                                            .favoriteDrink(drink);
                                        await progress.hide();
                                        if (drink.isFavorite &&
                                            onFavoriteRemove != null) {
                                          onFavoriteRemove();
                                        }
                                      },
                                      child: Icon(
                                        MaterialCommunityIcons.heart,
                                        color: drink.isFavorite
                                            ? AppColors.sweetRed
                                            : Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Positioned(
                              bottom: -12,
                              right: -12,
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Icon(
                                      MaterialCommunityIcons.chevron_right,
                                      color: AppColors.primary,
                                      size: 26),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.lightOrange,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
