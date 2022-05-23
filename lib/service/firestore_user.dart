import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("users");

  Future<List<QueryDocumentSnapshot>> getUsers() async {
    QuerySnapshot results = await _userCollectionRef.get();
    return results.docs;
  }
}
