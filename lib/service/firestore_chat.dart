import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat/models/chat_message_model.dart';

class FireStoreChat {
  final CollectionReference _roomCollectionRef =
      FirebaseFirestore.instance.collection("rooms");

  Stream<QuerySnapshot> getChatMessage(
    String roomId,
  ) {
    return _roomCollectionRef
        .doc(roomId)
        .collection(roomId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void sendChatMessage(String content, int type, String roomId,
      String currentUserId, String peerId) async {
    CollectionReference ref = _roomCollectionRef.doc(roomId).collection(roomId);

    ChatMessageModel chatMessages = ChatMessageModel(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    await ref.add(chatMessages.toJson());
  }
}
