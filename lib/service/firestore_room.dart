import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreRoom {
  final CollectionReference _roomCollectionRef =
      FirebaseFirestore.instance.collection("rooms");

  Future<List<QueryDocumentSnapshot>> getRooms(String displayName) async {
    QuerySnapshot results = await _roomCollectionRef
        .where("members", arrayContainsAny: [displayName]).get();

    return results.docs;
  }

  Future<DocumentSnapshot> getRoomMessages() async {
    const docId = "test";
    DocumentSnapshot result = await _roomCollectionRef.doc(docId).get();

    return result;
  }
}
