import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/AuthScreen/RegisterScreen.dart';
import 'package:my_notes/Services/FirebaseException.dart';
import 'package:my_notes/Services/Validations.dart';
import 'package:my_notes/Widgets/SlidingBottom.dart';
import 'package:my_notes/Widgets/MyBar.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/MyField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _email2 = '';
  String _password = '';
  bool isLoading = false;
  bool _autoValidate = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: SvgPicture.asset(
                  'assets/note.svg',
                ),
              ),
              Form(
                autovalidate: _autoValidate,
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      MyField(
                        isEmail: true,
                        title: 'Email...',
                        icon: Icons.email_outlined,
                        onChanged: (val) {
                          _email = val;
                        },
                        validator: (val) => Validations.emailValidation(val),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MyField(
                        
                        title: 'Password...',
                        icon: Icons.lock_open,
                        onChanged: (val) {
                          _password = val;
                        },
                        isPassword: true,
                        validator: (val) => Validations.passwordValidation(val),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                            ),
                            onPressed: () {
                              SlidingBottom.showAsBottomSheet(
                                  title: 'Reset Password',
                                  textFieldHint: 'Enter your email...',
                                  buttonText: 'Reset Password',
                                  context: context,
                                  emailValidation: true,
                                  btnFunction: (String email) async {
                                    try {
                                      await User.resetPassword(email);
                                      Navigator.pop(context);
                                      MyBar.customFlushBar(
                                          context: context,
                                          icon: Icons.check,
                                          message:
                                              'Password link has been sent to your email');
                                    } on PlatformException catch (e) {
                                      String msg = FirebaseException
                                          .generateReadableMessage(e);
                                      MyBar.customFlushBar(
                                          context: context,
                                          icon: Icons.warning_amber_outlined,
                                          message: msg);
                                    }
                                  });
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      isLoading
                          ? SpinKitFadingCube(
                              color: Colors.redAccent,
                              size: 20.0,
                            )
                          : MyButton(
                              borderColor: Colors.pink[800],
                              btnText: 'Sign In',
                              function: () async {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    User user = new User(
                                        email: _email, password: _password);
                                    await user.login();
                                  } on PlatformException catch (exception) {
                                    String msg = FirebaseException
                                        .generateReadableMessage(
                                      exception,
                                    );
                                    MyBar.customFlushBar(
                                        context: context,
                                        message: msg,
                                        icon: Icons.warning_amber_rounded);
                                  }
                                }

                                setState(() {
                                  isLoading = false;
                                  _autoValidate = true;
                                });
                              },
                            ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                        },
                        child: Text('Don\'t have an account? Register'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
