import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_notes/Models/Account.dart';
import 'package:my_notes/Services/Authentication.dart';
import 'package:my_notes/Services/AvatarGenerator.dart';
import 'package:my_notes/Services/Database.dart';
import 'package:path/path.dart' as Path;
import 'Note.dart';

class User extends Account {
  String id;
  String sex;
  User({
    String name,
    String email,
    String password,
    String id,
    String imageUrl,
    String sex,
  }) : super(
            name: name,
            email: email,
            password: password,
            imageUrl: imageUrl,
            sex: sex) {
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': super.getName(),
      'email': super.getEmail(),
      'id': getID(),
      'imageUrl': getImage(),
      'sex': getSex(),
    };
  }

  User fromJson(Map json) {
    return new User(
      name: json['name'],
      email: json['email'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      sex: json['sex'],
    );
  }

  Future<User> fetch(String id) async {
    DocumentSnapshot doc;
    try {
      doc = await Database.getDocument(id, Database.usersCollection);
    } catch (e) {
      logout();
    }
    return fromJson(doc.data);
  }

  Future<void> updateUser() async {
    try {
      await Firestore.instance
          .collection('Users')
          .document(getID())
          .setData(this.toJson());
    } catch (e) {
      print('######### ' + e.toString());
    }
  }

  Future<void> changeAvatar(String sexType) async{
    sexType == 'MALE'
        ? this.setImageUrl(AvatarGenerator.generateMaleAvatar())
        : this.setImageUrl(AvatarGenerator.generateFemaleAvatar());
    await this.updateUser();
  }

  Future<void> addNote(Note note, bool isPublic) async {
    isPublic
        ? {
            await Firestore.instance
                .collection('Public')
                .document()
                .setData(note.toJson()),
            await Firestore.instance
                .collection('Notes')
                .document()
                .setData(note.toJson())
          }
        : await Firestore.instance
            .collection('Notes')
            .document()
            .setData(note.toJson());
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

  static Future<void> resetPassword(String email)async{
    await Authentication.resetPassword(email: email);
  }

  // Future<void> deleteAccount(String userID) async {
  //   return await Authentication.deleteAccount(userID);
  // }
  String getID() => id ?? '';

  void setID(String value) {
    this.id = value;
  }
}
