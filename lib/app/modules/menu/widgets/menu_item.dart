import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String translateKey;
  final IconData icon;
  final Function onPressed;

  const MenuItem({Key key, this.translateKey, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            Text(
              Translate(context).text(translateKey),
              style: TextStyle(
                  color: AppColors.strongGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
