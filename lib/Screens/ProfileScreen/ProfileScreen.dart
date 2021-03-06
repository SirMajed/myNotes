import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_notes/Models/Account.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Screens/ProfileScreen/Avatar.dart';
import 'package:my_notes/Screens/ProfileScreen/ProfileCard.dart';
import 'package:my_notes/Services/Authentication.dart';
import 'package:my_notes/Services/AvatarGenerator.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:my_notes/Services/FirebaseException.dart';
import 'package:my_notes/Widgets/MyBar.dart';
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
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Users')
          .document(user.getID())
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.data != null && snapshot.data.exists) {
          return MyScaffold(
            title: snapshot.data['sex'] == 'NONE'
                ? 'Select your gender'
                : 'Profile',
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
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.data != null && snapshot.data.exists) {
                          var userDocument = snapshot.data;
                          if (userDocument['sex'] == 'NONE') {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: getContainer(
                                    onPress: () {
                                      user.setSex(Sex.MALE.toString());
                                      user.setImageUrl(
                                          AvatarGenerator.generateMaleAvatar());
                                      user.updateUser();
                                    },
                                    cardChild: FaIcon(
                                      FontAwesomeIcons.male,
                                      size: 50,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                                Text('OR'),
                                Expanded(
                                  child: getContainer(
                                    onPress: () {
                                      user.setSex(Sex.FEMALE.toString());
                                      user.setImageUrl(AvatarGenerator
                                          .generateFemaleAvatar());
                                      user.updateUser();
                                    },
                                    cardChild: FaIcon(
                                      FontAwesomeIcons.female,
                                      size: 50,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              Avatar(
                                imageUrl: userDocument['imageUrl'],
                                userID: user.getID(),
                              ),
                              SizedBox(
                                height: 10,
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
                                        child: Text(
                                          userDocument['name'],
                                          style: TextStyle(fontSize: 16),
                                        ),
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
                                  ProfileCard(
                                    loading: loading,
                                    function: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 500),
                                          () async {
                                        await user.changeAvatar(user.getSex());
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    },
                                    icon: Icons.face,
                                    title: 'Generate Avatar',
                                  ),
                                  ProfileCard(
                                    function: () async {
                                      await user.logout();
                                      MyBar.customFlushBar(
                                          context: context,
                                          message: 'Logged out',
                                          icon: Icons.check);
                                    },
                                    icon: Icons.logout,
                                    title: 'Sign Out',
                                  ),
                                  ProfileCard(
                                    function: () {
                                      setState(() {
                                        loading = true;
                                      });
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
                                          try {
                                            await Authentication.deleteAccount(
                                              email: user.getEmail(),
                                              password: _password,
                                              userID: user.getID(),
                                            );
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            MyBar.customFlushBar(
                                                context: context,
                                                message: 'Account deleted!',
                                                icon: Icons.check);
                                          } on PlatformException catch (ex) {
                                            String msg = FirebaseException
                                                .generateReadableMessage(ex);
                                            MyBar.customFlushBar(
                                                context: context,
                                                message: msg,
                                                icon: Icons
                                                    .warning_amber_rounded);
                                          }
                                        },
                                      ).displayDialog(context);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    icon: Icons.delete,
                                    title: 'Delete Account',
                                  ),
                                ],
                              ),
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
        return SizedBox();
      },
    );
  }

  Widget getContainer({Function onPress, Widget cardChild}) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 150,
        child: Center(child: cardChild),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
