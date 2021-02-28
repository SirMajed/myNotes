import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/AuthScreen/LoginScreen.dart';
import 'package:my_notes/Services/FirebaseException.dart';
import 'package:my_notes/Services/Validations.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/MyField.dart';

class RegisterScreen extends StatefulWidget {
  // In this class we will check if user logged in or not
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _password = '';
  String _name = '';
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
                key: formKey,
                autovalidate: _autoValidate,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      MyField(
                        title: 'Name...',
                        icon: Icons.person,
                        onChanged: (val) {
                          _name = val;
                        },
                        validator: (val)=>Validations.isEmptyValidation(val),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MyField(
                        title: 'Email...',
                        icon: Icons.email_outlined,
                        onChanged: (val) {
                          _email = val;
                        },
                        isEmail: true,
                        validator: (val)=>Validations.emailValidation(val),
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
                        validator: (val)=>Validations.passwordValidation(val),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : MyButton(
                              btnText: 'Register',
                              borderColor: Colors.purple[600],
                              function: () async {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    User user = new User(
                                      email: _email,
                                      password: _password,
                                      name: _name,
                                    );

                                    await user.register();
                                    Navigator.pop(context);
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) => Provider<User>.value(
                                    //     value: user,
                                    //     child: HomeScreen()),
                                    // ));
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
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Text('Already have an account? Login'),
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
