import 'package:easydrink/app/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AppProgressDialog {
  final BuildContext context;
  final String text;
  final ProgressDialogType type;
  ProgressDialog pr;
  Function show;
  Function hide;
  Function update;

  AppProgressDialog(this.context, this.text,
      {this.type: ProgressDialogType.Normal}) {
    pr = ProgressDialog(context,
        type: this.type, isDismissible: false, showLogs: true);

    pr.style(
        progress: 0.0,
        maxProgress: 100.0,
        message: text,
        backgroundColor: AppColors.bg,
        messageTextStyle:
            TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),
        progressWidget: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ));

    show = pr.show;
    hide = pr.hide;
    update = pr.update;
  }
}
