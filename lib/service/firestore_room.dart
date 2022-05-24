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

  Future<DocumentSnapshot> getRoomMessages(String roomId) async {
    return await _roomCollectionRef.doc(roomId).get();
  }

  void createRoom(List<String> members, BuildContext context, String peerId) {
    _roomCollectionRef.add({"members": members}).then((value) => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetailView(roomId: value.id, peerId: peerId))),
          Fluttertoast.showToast(msg: "채팅방이 생성되었습니다.")
        });
  }

  void findRoom(List<String> members, BuildContext context, String peerId) {
    _roomCollectionRef
        .where("members", isEqualTo: members)
        .limit(1)
        .get()
        .then((res) => {
              if (res.docs.isEmpty)
                {createRoom(members, context, peerId)}
              else
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatDetailView(roomId: res.docs.first.id, peerId: peerId))),
                  Fluttertoast.showToast(msg: "채팅방으로 이동하였습니다.")
                }
            });
  }
}
