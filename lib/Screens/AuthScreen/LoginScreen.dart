import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/AuthScreen/RegisterScreen.dart';
import 'package:my_notes/Services/FirebaseException.dart';
import 'package:my_notes/Services/Validations.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/MyField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
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
                      SizedBox(
                        height: 40,
                      ),
                      isLoading
                          ? CircularProgressIndicator()
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
                                      email: _email,
                                      password: _password,
                                    );
                                    await user.login();
                                  } on PlatformException catch (exception) {
                                    String msg = FirebaseException
                                        .generateReadableMessage(
                                            exception); //firebase exception happened
                                    BotToast.showSimpleNotification(
                                      title: msg,
                                      backgroundColor: Colors.redAccent,
                                      closeIcon:
                                          Icon(Icons.warning_amber_rounded),
                                      align: Alignment.bottomCenter,
                                      borderRadius: 8,
                                      hideCloseButton: false,
                                    );
                                  } catch (e) {
                                    print('Undefined error');
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
