import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_notes/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_notes/Screens/WelcomeScreen/WelcomeScreen.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _firstTime = (prefs.getBool('seen') ?? false);

    if (_firstTime) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MyApp()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new WelcomeScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: SpinKitFadingCube(
                    color: Colors.redAccent,
                    size: 40.0,
                  ),
      ),
    );
  }
}
