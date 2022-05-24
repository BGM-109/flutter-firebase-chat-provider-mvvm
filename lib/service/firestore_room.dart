import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/views/chat_detail_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireStoreRoom {
  final CollectionReference _roomCollectionRef =
      FirebaseFirestore.instance.collection("rooms");

  Future<List<QueryDocumentSnapshot>> getRooms(String docId) async {
    QuerySnapshot results = await _roomCollectionRef
        .where("members", arrayContainsAny: [docId]).get();

    return results.docs;
  }

  Future<DocumentSnapshot> getRoomMessages() async {
    const docId = "test";
    DocumentSnapshot result = await _roomCollectionRef.doc(docId).get();

    return result;
  }

  void createRoom(List<String> members, BuildContext context) {
    _roomCollectionRef.add({"members": members}).then((value) => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetailView(roomId: value.id))),
          Fluttertoast.showToast(msg: "채팅방이 생성되었습니다.")
        });
  }

  void findRoom(List<String> members, BuildContext context) {
    _roomCollectionRef
        .where("members", isEqualTo: members)
        .limit(1)
        .get()
        .then((res) => {
          if(res.docs.isEmpty) {
            createRoom(members, context)
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetailView(roomId: res.docs.first.id))),
            Fluttertoast.showToast(msg: "채팅방으로 이동하였습니다.")
          }
    });
  }
}
