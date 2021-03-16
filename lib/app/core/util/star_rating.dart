import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rating_dialog/rating_dialog.dart';

class StarRating {
  static void show(Function(int rating) onSubmitPressed, BuildContext context,
      String titleTranslateKey,
      {description: ""}) {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Icon(MaterialCommunityIcons.star,
                size: 80,
                color: AppColors.primary), // set your own image/icon widget
            title: Translate(context).text(titleTranslateKey),
            description: description,
            submitButton: Translate(context).text("finish").toUpperCase(),
            alternativeButton: "", // optional
            positiveComment: "", // optional
            negativeComment: "", // optional
            accentColor: AppColors.primary, // optional
            onSubmitPressed: onSubmitPressed,
            onAlternativePressed: () {},
          );
        });
    /* showMaterialModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              color: Colors.white,
              height: 470,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 12),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(MaterialCommunityIcons.star,
                                size: 36, color: AppColors.primary),
                          ),
                          Text(
                            Translate(context).text("ratingDrink"),
                            style: TextStyle(
                                color: AppColors.sweetBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {
                          print(v);
                        },
                        starCount: 5,
                        rating: 3.0,
                        defaultIconData: Icons.star_border,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        size: 40.0,
                        isReadOnly: true,
                        color: AppColors.primary,
                        borderColor: AppColors.primary,
                        spacing: 2.0)
                  ]),
            ));*/
  }
}
