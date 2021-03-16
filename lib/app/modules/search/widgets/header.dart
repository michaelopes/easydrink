import 'package:easydrink/app/core/const/app_assets.dart';
import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class Header extends StatelessWidget {
  final Function onPressed;

  const Header({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Translate(context).text("search.title"),
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.sweetBlack)),
              SizedBox(
                height: 10,
              ),
              Text(Translate(context).text("search.subtitle"),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.subtitleGrey))
            ],
          ),
          Container(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: onPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.filterIcon,
                    width: 30,
                  ),
                  Text(Translate(context).text("filters"),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          color: Colors.white)),
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
    );
  }
}
