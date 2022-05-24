import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/service/firestore_room.dart';

class ChatViewModel extends ChangeNotifier {
  Stream<QuerySnapshot> fetchRooms(String userId) {
    return FireStoreRoom().getRoomsFromUserId(userId);
  }
}
