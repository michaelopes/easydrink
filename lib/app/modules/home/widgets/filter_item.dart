import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final Function onPressed;
  final bool isActive;
  final String iconAsset;
  final String translateKey;

  const FilterItem(
      {Key key,
      this.onPressed,
      this.isActive,
      this.iconAsset,
      this.translateKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.transparent,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 4),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translate(context).text("findBy"),
                            style: TextStyle(
                                color: AppColors.subtitleGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            Translate(context).text(translateKey),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.sweetBlack,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.sweetBlack.withOpacity(.3),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(iconAsset), fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: AppColors.sweetGrey),
                ),
              ),
            ],
          ),
        ));
  }
}
