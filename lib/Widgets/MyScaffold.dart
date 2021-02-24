import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  MyScaffold({this.title, this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 30,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
