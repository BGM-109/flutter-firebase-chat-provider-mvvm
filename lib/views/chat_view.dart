import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_viewmodel.dart';
import 'package:flutter_firebase_chat/views/chat_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_chat/constants.dart' as constants;

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    return StreamBuilder<QuerySnapshot>(
        stream: vm.fetchRooms(constants.CURRENT_USER_ID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var listRooms = snapshot.data!.docs;
            if (listRooms.isNotEmpty) {
              return ListView.builder(
                itemCount: listRooms.length,
                itemBuilder: (context, index) {
                  String peerId = snapshot.data!.docs[index]["members"][0];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatDetailView(
                                    roomId: snapshot.data!.docs[index].id,
                                    peerId: peerId)));
                      },
                      child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text("${peerId} 님과의 방")));
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
