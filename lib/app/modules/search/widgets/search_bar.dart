import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:easydrink/app/core/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onCleaned;
  final Function(String text) onSearch;

  const SearchBar(
      {Key key, this.controller, this.onCleaned, this.onSearch, this.focusNode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Icon(
                    Feather.search,
                    color: AppColors.pastelGrey,
                  ),
                ),
                Expanded(
                    child: TextField(
                  textInputAction: TextInputAction.search,
                  focusNode: focusNode,
                  onChanged: (text) {
                    if (text.trim().isEmpty && onCleaned != null) {
                      onCleaned();
                    }
                  },
                  onSubmitted: (text) {
                    if (onSearch != null) {
                      if (focusNode != null) {
                        focusNode.unfocus();
                      }
                      onSearch(text);
                    }
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: AppColors.pastelGrey, fontSize: 14),
                      hintText: Translate(context).text("search.barHintText")),
                )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: InkWell(
            onTap: () {
              if (onSearch != null) {
                if (focusNode != null) {
                  focusNode.unfocus();
                }
                onSearch(controller.text);
              }
            },
            child: Container(
              height: 50,
              width: 50,
              child: Icon(
                MaterialCommunityIcons.arrow_right,
                color: AppColors.primary,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
