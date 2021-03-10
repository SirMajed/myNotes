import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final Function function;
  final Color borderColor;
  final Color textColor;
  final bool isExpanded;
  final double btnWidth;
  MyButton({this.btnText, this.function,this.borderColor = Colors.red,this.textColor,
  this.isExpanded = true,this.btnWidth
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : btnWidth,
      height: 40,
      child: FlatButton(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: borderColor == null ? Colors.redAccent : borderColor.withOpacity(0.1),
        onPressed: () => function(),
        child: Text(
          btnText,
          style: TextStyle(
            color: textColor
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: borderColor)),
      ),
    );
  }
}
