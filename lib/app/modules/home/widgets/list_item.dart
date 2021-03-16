import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ListItem extends StatelessWidget {
  final Category category;
  final Function(Category category) onPressed;
  final Color circleColor;

  const ListItem(
      {Key key,
      this.category,
      this.onPressed,
      this.circleColor = AppColors.sweetOrange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed(category);
          }
        },
        child: Container(
          height: 64,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  category.description,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.strongGrey,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  width: 46,
                  height: 46,
                  child: Center(
                    child: Icon(MaterialCommunityIcons.chevron_right,
                        color: AppColors.primary, size: 32),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.lightOrange, shape: BoxShape.circle),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
