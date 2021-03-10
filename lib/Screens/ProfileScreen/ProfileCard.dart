import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileCard extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData icon;
  final bool loading;

  ProfileCard({this.onPressed, this.title, this.icon, this.loading = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 5,
      child: ListTile(
        onTap: ()=> onPressed(),
        leading: loading
            ? SizedBox()
            : Icon(
                icon,
                color: Colors.redAccent,
              ),
        title: loading
            ? Container(
                padding: EdgeInsets.only(right: 60),
                alignment: Alignment.centerLeft,
                child: Center(child: SpinKitFadingCube(
                    color: Colors.redAccent,
                    size: 20.0,
                  ),),
              )
            : Text(title),
      ),
    );
  }
}
