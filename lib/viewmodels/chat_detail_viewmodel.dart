import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/service/firestore_chat.dart';

class ChatDetailViewModel extends ChangeNotifier {
  Stream<QuerySnapshot> getMessages(String roomId) {
    return FireStoreChat().getChatMessage(roomId);
  }

  void sendMessage(String content, int type, String roomId,
      String currentUserId, String peerId) {
    FireStoreChat()
        .sendChatMessage(content, type, roomId, currentUserId, peerId);
  }
}
