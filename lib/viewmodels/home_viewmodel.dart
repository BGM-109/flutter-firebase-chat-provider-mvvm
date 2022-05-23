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
        _userList.add(UserModel(docs[i]["name"], docs[i]["profileImg"]));
      }
    });
    _isLoad = false;
    notifyListeners();
  }
}
