import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_viewmodel.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    const currentUserId = "gn3jZorLmdhqN9KzEva8";
    return StreamBuilder<QuerySnapshot>(
        stream: vm.fetchRooms(currentUserId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var listRooms = snapshot.data!.docs;
            if (listRooms.isNotEmpty) {
              return ListView.builder(
                itemCount: listRooms.length,
                itemBuilder: (context, index) {
                  String peerId = snapshot.data!.docs[index]["members"][0];
                  return Text("${peerId} 님과의 방");
                },
              );
            } else {
              return const Center(
                child: Text("채팅방이 없습니다."),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
        });
  }
}
