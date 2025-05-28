import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/colors.dart';


showMessage(
    String message, {
      bool hasError = true,
      Color? backGroundColor,
      Color? foreGroundColor,
      Toast timeShowing = Toast.LENGTH_LONG,
    }) {
  if(message == 'null') return;
  Fluttertoast.cancel().then((value) => Fluttertoast.showToast(
    msg: message,
    backgroundColor: backGroundColor ?? Colors.grey.shade300,
    textColor: foreGroundColor ?? const Color(0xff2661B2),
    fontSize: 16,
    toastLength: timeShowing,
    gravity: ToastGravity.BOTTOM,
  ));
}
