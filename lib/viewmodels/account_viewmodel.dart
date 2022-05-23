import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';

class AccountViewModel extends ChangeNotifier {
  UserModel _currentUser = UserModel("음바페", "https://firebasestorage.googleapis.com/v0/b/flutter-firebase-chat-mvvm.appspot.com/o/umbape.jpeg?alt=media&token=ede79999-21a4-4172-9a9f-1c671e1026f6");

  UserModel get currentUser => _currentUser;

  void changeUser(String name) {
    final UserModel inputUser = UserModel(name, "https://firebasestorage.googleapis.com/v0/b/flutter-firebase-chat-mvvm.appspot.com/o/umbape.jpeg?alt=media&token=ede79999-21a4-4172-9a9f-1c671e1026f6");
    _currentUser = inputUser;
    notifyListeners();
  }
}
