import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/service/firestore_chat.dart';

class ChatDetailViewModel extends ChangeNotifier {
  ChatDetailViewModel() {
    getMessages("test");
  }

  Stream<QuerySnapshot> getMessages(String roomId) {
    return FireStoreChat().getChatMessage("test");
  }

  void sendMessage(String content) {
    FireStoreChat().sendChatMessage(content, 1, "test", "조바이든", "트럼프");
  }
}
