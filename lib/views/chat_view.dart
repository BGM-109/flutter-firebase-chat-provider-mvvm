import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_viewmodel.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    return ListView(
      children: vm.rooms.map((r) => Text(r["from"])).toList(),
    );
  }
}
