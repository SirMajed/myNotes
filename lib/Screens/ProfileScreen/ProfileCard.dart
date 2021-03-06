import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Function function;
  final String title;
  final IconData icon;
  final bool loading;

  ProfileCard({this.function, this.title, this.icon, this.loading = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 5,
      child: ListTile(
        onTap: loading ? null : function,
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
                child: Center(child: CircularProgressIndicator(strokeWidth: 3)),
              )
            : Text(title),
      ),
    );
  }
}
