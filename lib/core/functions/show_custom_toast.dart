import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/app_colors.dart';

enum ToastType { success, error, info }

void showCustomToast(String msg, {ToastType type = ToastType.info}) {
  Color textColor;

  switch (type) {
    case ToastType.success:
      textColor = AppColors.gray;
      break;
    case ToastType.error:
      textColor = AppColors.red;
      break;
    case ToastType.info:
      textColor = AppColors.black;
      break;
  }

  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.white,
    textColor: textColor,
    fontSize: 16.0,
  );
}
