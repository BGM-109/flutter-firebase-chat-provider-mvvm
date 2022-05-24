import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef = FirebaseFirestore.instance
      .collection("users")
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<List<QueryDocumentSnapshot>> getUsers() async {
    QuerySnapshot results = await _userCollectionRef.get();
    return results.docs;
  }

  Future<DocumentSnapshot> getUserFromId(String docId) async {
    return await _userCollectionRef.doc(docId).get();
  }

  Future<void> updateUserNameFromId(String docId, String name) {
    return _userCollectionRef
        .doc(docId)
        .update({'name': name})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
