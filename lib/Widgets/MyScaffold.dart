import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool hasButton;
  final Function globalNotes;
  final Function currentUserNotes;
  MyScaffold(
      {this.title,
      this.body,
      this.hasButton = false,
      this.globalNotes,
      this.currentUserNotes});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Spacer(),
              hasButton
                  ? IconButton(
                      icon: FaIcon(FontAwesomeIcons.globeAmericas),
                      onPressed: () => globalNotes(),
                      splashColor: Colors.redAccent.withOpacity(0.2),
                      splashRadius: 20,
                    )
                  : SizedBox(),
              hasButton
                  ? IconButton(
                      icon: FaIcon(FontAwesomeIcons.user),
                      onPressed: () => currentUserNotes(),
                      splashColor: Colors.redAccent.withOpacity(0.2),
                      splashRadius: 20,
                    )
                  : SizedBox(),
            ],
          ),
          body,
        ],
      ),
    );
  }
}
