import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/service/firestore_room.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel() {
    fetchRooms();
  }

  final List _rooms = [];

  List get rooms => _rooms;

  void fetchRooms() async {
    FireStoreRoom().getRooms("음바페").then((docs) {
      for (int i = 0; i < docs.length; i++) {
        _rooms.add({
          "from": docs[i]["members"][0].toString(),
        });
      }
    });
    notifyListeners();
  }
}
