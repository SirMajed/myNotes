import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/Models/Account.dart';
import 'package:my_notes/Models/User.dart';

class Authentication {
  static final FirebaseAuth _instance = FirebaseAuth.instance;
  Authentication._();

  static Stream<FirebaseUser> getUserState() {
    return _instance.onAuthStateChanged;
  }

  static Future<void> signIn(Account account) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: account.getEmail(), password: account.getPassword());
    } catch (e) {
      signOut();
      rethrow;
    }
  }

  static Future<void> signUp(Account account) async {
    AuthResult res;
    try {
      res = await _instance.createUserWithEmailAndPassword(
          email: account.getEmail(), password: account.getPassword());
      (account as User).id = res.user.uid;

      await Firestore.instance
          .collection('Users')
          .document((account as User).id)
          .setData((account as User).toJson(), merge: true);

      await signIn(account);
    } catch (e) {
      print(e.toString());
      signOut();
      rethrow;
    }
  }


  static Future<void> deleteAccount(String userID) async {
    FirebaseUser user = await _instance.currentUser();
    try {
      Firestore.instance
          .collection("Users")
          .where("id", isEqualTo: userID)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          Firestore.instance
              .collection("Users")
              .document(element.documentID)
              .delete()
              .then((value) {
            user.delete();
          });
        });
      });

      // await Database.deleteUserDocument(userID).then((value) {
      //   user.delete();
      // });
    } on PlatformException catch (e) {
      print(e.message.toString());
      signOut();
    }
  }

  static Future<void> signOut() async {
    return await _instance.signOut();
  }
}
