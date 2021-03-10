import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/main.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyApp()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: SvgPicture.asset(
        'assets/$assetName',
        width: 200,
        height: 200,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0, fontFamily: 'Baloo Bhai 2');
    const pageDecoration = const PageDecoration(
        titlePadding: EdgeInsets.zero,
        titleTextStyle: TextStyle(
            fontSize: 28, fontFamily: 'BalooBhai', color: Colors.redAccent),
        bodyTextStyle: bodyStyle,
        descriptionPadding: EdgeInsets.symmetric(horizontal: 12),
        pageColor: Color(0xff101630),
        imagePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(vertical: 40),
        footerPadding: EdgeInsets.symmetric(vertical: 39));

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Write",
          body: "Write down your thoughts and what is going on around you",
          image: _buildImage('write.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Publish",
          body:
              "You can publish your notes to public if you wish and let other users see what have you been wrote",
          image: _buildImage('share.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Share",
          body: "You can share any of your notes to other platforms",
          image: _buildImage('share_content.svg'),
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyButton(
              btnText: 'Get Started',
              function: () {
                return _onIntroEnd(context);
              },
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      //done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.redAccent)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeColor: Colors.redAccent,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
