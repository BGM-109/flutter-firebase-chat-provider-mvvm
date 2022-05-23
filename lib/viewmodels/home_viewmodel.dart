import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    fetchUserList();
  }

  final List<UserModel> _userList = [];

  List<UserModel> get userList => _userList;

  bool _isLoad = false;

  bool get isLoad => _isLoad;

  Future<void> fetchUserList() async {
    _isLoad = true;
    notifyListeners();
    FireStoreUser().getUsers().then((docs) {
      for (int i = 0; i < docs.length; i++) {
        _userList.add(UserModel(docs[i]["name"],
            "https://firebasestorage.googleapis.com/v0/b/flutter-firebase-chat-mvvm.appspot.com/o/c5c470298d527ef65eb52883f0f186c48f324a0b9c48f77dbce3a43bd11ce785.png?alt=media&token=ba08de8e-4b0c-453d-b5e4-0a3663329359"));
      }
    });
    _isLoad = false;
    notifyListeners();
  }
}
