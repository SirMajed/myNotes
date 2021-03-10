import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/AuthScreen/LoginScreen.dart';
import 'package:my_notes/Screens/HomeScreen/HomeScreen.dart';
import 'package:my_notes/Screens/WelcomeScreen/WelcomeScreen.dart';
import 'package:my_notes/Services/Authentication.dart';
import 'package:my_notes/Widgets/Splash.dart';
import 'package:provider/provider.dart';
import 'Models/Note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoder,
      'assets/note.svg',
    ),
    null,
  );
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoder,
      'assets/share_content.svg',
    ),
    null,
  );
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoder,
      'assets/share.svg',
    ),
    null,
  );
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoder,
      'assets/write.svg',
    ),
    null,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF101630), //0A0E21
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        accentColor: Colors.redAccent,
        textSelectionColor: Colors.pink[900],
      ),
      home: MultiProvider(providers: [
        Provider<Note>(
          create: (context) => Note(),
        ),
      ], child:  Splash()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: Authentication.getUserState(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('No User');
          return LoginScreen();
        } else {
          // data exists
          return FutureBuilder(
            future: User().fetch(snapshot.data.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Provider<User>.value(
                      value: snapshot.data, child: HomeScreen());
                } else {
                  return SizedBox();
                }
              } else {
                return Scaffold(body: SizedBox());
              }
            },
          );
        }
      },
    );
  }
}
