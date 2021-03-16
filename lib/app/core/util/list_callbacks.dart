import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ListCallbacks {
  static Widget noItemsFoundIndicator(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            Translate(context).text("listExeptionsResult.noItemsTitle"),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.contrast, fontSize: 20),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            Translate(context).text("listExeptionsResult.noItemsMsg"),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.contrast, fontSize: 16),
          )
        ],
      ),
    );
  }

  static Widget firstLoadError(BuildContext context, {Function onTryAgain}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            Translate(context).text("listExeptionsResult.noItemsTitle"),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.contrast, fontSize: 20),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            Translate(context).text("listExeptionsResult.noItemsMsg"),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.contrast, fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: onTryAgain != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 220,
                height: 42,
                child: RaisedButton(
                  child: Icon(Feather.refresh_cw, color: Colors.white),
                  onPressed: onTryAgain,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
