import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MyBar {
  static Flushbar customFlushBar({BuildContext context, String message,IconData icon}) {
    return Flushbar(
      message: message,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: Duration(milliseconds: 1500),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      backgroundColor: Colors.redAccent,
      shouldIconPulse: false,
      isDismissible: true,
      icon: Icon(
        icon,
        size: 24,
      ),
      animationDuration: Duration(milliseconds: 300),
    )..show(context);
  }
}
