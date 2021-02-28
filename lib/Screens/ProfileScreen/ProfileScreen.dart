import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/ProfileScreen/Avatar.dart';
import 'package:my_notes/Services/Authentication.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:my_notes/Widgets/MyButton.dart';
import 'package:my_notes/Widgets/DialogWithField.dart';
import 'package:my_notes/Widgets/MyScaffold.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;
  String _newName = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context, listen: false);

    return MyScaffold(
      title: 'Profile',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('Users')
                    .document(user.getID())
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.data != null && snapshot.data.exists) {
                    var userDocument = snapshot.data;
                    return Column(
                      children: [
                        Avatar(
                          imageUrl: userDocument['imageUrl'],
                          userID: user.getID(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(userDocument['name']),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      DialogWithField(
                                        currentName: userDocument['name'],
                                        onChanged: (val) {
                                          _newName = val;
                                        },
                                        title: 'Change Your Name',
                                        hint: 'Enter your new name',
                                        positiveActionText: 'Update',
                                        positiveAction: () async {
                                          await Database.updateName(
                                              user.getID(), _newName);

                                          Navigator.pop(context);
                                        },
                                      ).displayDialog(context);
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MyButton(
                              btnText: 'Sign Out',
                              function: () async {
                                user.logout();
                                BotToast.showSimpleNotification(
                                  title: 'Logged out',
                                  backgroundColor: Colors.redAccent,
                                  closeIcon: Icon(Icons.check),
                                  align: Alignment.bottomCenter,
                                  borderRadius: 8,
                                  hideCloseButton: false,
                                );
                              },
                            ),
                            loading
                                ? CircularProgressIndicator()
                                : MyButton(
                                    btnText: 'Delete account',
                                    function: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      // DialogWithField(
                                      //     title:
                                      //         'Are you sure you want to delete your account?',
                                      //     negativeActionText: 'No',
                                      //     negativeAction: () =>
                                      //         Navigator.pop(context),
                                      //     positiveActionText: 'Yes',
                                      //     positiveAction: () async {
                                      //       await user
                                      //           .deleteAccount(user.getID());
                                      //       Navigator.pop(context);
                                      //       BotToast.showSimpleNotification(
                                      //         title: 'Account deleted!',
                                      //         backgroundColor: Colors.redAccent,
                                      //         closeIcon: Icon(
                                      //             Icons.warning_amber_rounded),
                                      //         align: Alignment.bottomCenter,
                                      //         borderRadius: 8,
                                      //         hideCloseButton: false,
                                      //       );
                                      //     }).confirmationDialog(context);
                                      DialogWithField(
                                        title: 'Please enter your password',
                                        hint: 'Password...',
                                        negativeActionText: 'No',
                                        negativeAction: () =>
                                            Navigator.pop(context),
                                        onChanged: (val) {
                                          _password = val;
                                        },
                                        isPassword: true,
                                        positiveActionText: 'Yes',
                                        positiveAction: () async {
                                          await Authentication.deleteAccount(
                                            email: user.getEmail(),
                                            password: _password,
                                            userID: user.getID(),
                                          );
                                          Navigator.pop(context);
                                          BotToast.showSimpleNotification(
                                            title: 'Account deleted!',
                                            backgroundColor: Colors.redAccent,
                                            closeIcon: Icon(
                                                Icons.warning_amber_rounded),
                                            align: Alignment.bottomCenter,
                                            borderRadius: 8,
                                            hideCloseButton: false,
                                          );
                                        },
                                      ).displayDialog(context);

                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                  ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
