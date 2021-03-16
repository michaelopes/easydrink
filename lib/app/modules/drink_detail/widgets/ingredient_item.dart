import 'package:cached_network_image/cached_network_image.dart';
import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/modules/drink_detail/drink_detail_controller.dart';
import 'package:flutter/material.dart';

class IndredientItem extends StatelessWidget {
  final String ingredient;
  final String measure;
  final DrinkDetailController controller;

  const IndredientItem(
      {Key key, this.ingredient, this.measure, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: CachedNetworkImage(
                width: 50,
                imageUrl:
                    "https://www.thecocktaildb.com/images/ingredients/$ingredient-Medium.png",
                imageBuilder: (context, imageProvider) => Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        /* borderRadius: BorderRadius.circular(5),
                        color: AppColors.sweetGrey,*/
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover))),
                placeholder: (context, url) => Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: controller.getTranslatedText(ingredient),
                    builder: (context, snapshot) {
                      var text = "";
                      if (snapshot.hasData) {
                        text = snapshot.data;
                      } else {
                        text = ingredient;
                      }
                      return Text(
                        text,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.strongGrey,
                            fontSize: 18),
                      );
                    }),
                SizedBox(
                  height: 3,
                ),
                Text(
                  measure,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.pastelGrey,
                      fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
