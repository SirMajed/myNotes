import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/Models/Account.dart';
import 'package:my_notes/Services/Authentication.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:path/path.dart' as Path;
import 'Note.dart';

class User extends Account {
  String id;

  User({String name, String email, String password, String id, String imageUrl})
      : super(
            name: name, email: email, password: password, imageUrl: imageUrl) {
    this.id = id;
  }

  // Future<DocumentSnapshot> getD() async{
  //    DocumentSnapshot doc = await Firestore.instance.collection('Notes')
  //   .document(getID())
  //   .get();
  //   print(doc.data['date']);
  //   return doc;
  // }

  Map<String, dynamic> toJson() {
    return {
      'name': super.getName(),
      'email': super.getEmail(),
      'id': getID(),
      'imageUrl': getImage(),
    };
  }

  User fromJson(Map json) {
    return new User(
      name: json['name'],
      email: json['email'],
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  Future<User> fetch(String id) async {
    DocumentSnapshot doc;
    try {
      doc = await Database.getDocument(id, Database.usersCollection);
      ;
    } catch (e) {
      logout();
    }
    return fromJson(doc.data);
  }

  Future<void> addNote(Note note, bool isPublic) async {
    await Firestore.instance
        .collection(isPublic ? 'Public' : 'Notes')
        .document()
        .setData(note.toJson(), merge: true);
  }

  static void uploadFile(File file, String userID) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('${Path.basename(file.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    String imgUrl = await storageReference.getDownloadURL() as String;
    Firestore.instance.collection('Users').document(userID).updateData({
      'imageUrl': imgUrl,
    });
  }

  @override
  Future<void> login() async {
    return await Authentication.signIn(this);
  }

  @override
  Future<void> logout() async {
    return await Authentication.signOut();
  }

  @override
  Future<void> register() async {
    return await Authentication.signUp(this);
  }

  Future<void> deleteAccount(String userID) async {
    return await Authentication.deleteAccount(userID);
  }

  String getID() => id ?? '';

  void setID(String value) {
    this.id = value;
  }
}
