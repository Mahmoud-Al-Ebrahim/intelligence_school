import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/colors.dart';


showMessage(
  String message, {
  Toast timeShowing = Toast.LENGTH_LONG,
}) {
    Fluttertoast.cancel().then((value) => Fluttertoast.showToast(
          msg: message,
          backgroundColor: secondaryColor,
          textColor: primaryColor,
          gravity: ToastGravity.BOTTOM,
        ));
}

