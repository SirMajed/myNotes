import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/Models/Account.dart';
import 'package:my_notes/Models/User.dart';
import 'package:my_notes/Services/Database.dart';

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
          .setData((account as User).toJson());

      await signIn(account);
    } catch (e) {
      print(e.toString());
      signOut();
      rethrow;
    }
  }

  // static Future deleteAccount(String userID ,String password, String email) async {
  //   FirebaseUser user = await _instance.currentUser();
  //   try {
  //     Database.deleteUserDocuments(userID);
  //     AuthResult result = await user.reauthenticateWithCredential(
  //         EmailAuthProvider.getCredential(
  //             email: email, password: password));
  //     await result.user.delete();
  //     // await Database.deleteUserDocument(userID).then((value) {
  //     //   user.delete();
  //     // });
  //   } catch (e) {
  //     if (user.uid != null) await user.delete();

  //     rethrow;
  //   }
  // }
  static Future deleteAccount({String userID ,String password, String email}) async {
    print(email);
    try {
      FirebaseUser user = await _instance.currentUser();
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email, password: password);
      print(user);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
     await Database.deleteUserDocuments(userID); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
}

  static Future<void> signOut() async {
    return await _instance.signOut();
  }
}
