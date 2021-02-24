import 'package:flutter/material.dart';

class MyBar {
  final String message;

  const MyBar({
    @required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        elevation: 0.0,
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),

        content: Text(message,
        style:TextStyle(fontSize: 16)),

        duration: new Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        //backgroundColor: Colors.redAccent,
      ),
    );
  }
}
