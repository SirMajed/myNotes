import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/Models/Note.dart';

class Database {
  Database._();
  static String usersCollection = 'Users';

  static Future<DocumentSnapshot> getDocument(
      String id, String collectionName) async {
    // if (id == null || id.isEmpty)
    //   throw new PlatformException(code: "Document not found");
    ////////////////////////
    return await Firestore.instance
        .collection(collectionName)
        .document(id)
        .get()
        .then((DocumentSnapshot doc) {
      // print(doc.data);
      if (doc.exists) {
        return doc;
      } else {
        print('Document not found');
        throw new PlatformException(code: "Document not found");
      }
    });
  }

  static Future<void> deleteUserDocument(String userID) async {
    await Firestore.instance.collection('Users').document(userID).delete();
  }

  static Stream<List<Note>> getNotes(String userID) {
    return Firestore.instance
        .collection('Notes')
        .where('id', isEqualTo: userID)
        .orderBy('date', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return Note().fromJson(doc.data);
      }).toList();
    });
  }

  static Future<void> updateName(String userID, String newName) async{
    await Firestore.instance
    .collection('Users')
    .document(userID)
    .updateData({
      'name': newName,
    });

  }

  static Future<void> deleteNote(Note note) async {
    return Firestore.instance
        .collection("Notes")
        .where('date', isEqualTo: note.getDate())
        .getDocuments()
        .then((value) {
      value.documents.forEach((docID) {
        Firestore.instance
            .collection("Notes")
            .document(docID.documentID)
            .delete()
            .then((value) {});
      });
    });
  }
}
