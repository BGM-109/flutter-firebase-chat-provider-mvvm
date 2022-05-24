import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_viewmodel.dart';
import 'package:flutter_firebase_chat/views/chat_detail_view.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    return ListView(
      children: vm.rooms
          .map((r) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatDetailView(roomId: "123")),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(r["from"]),
              )))
          .toList(),
    );
  }
}
