import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    fetchUserList();
  }

  final List<UserModel> _userList = [];

  List<UserModel> get userList => _userList;

  bool _isLoad = true;

  bool get isLoad => _isLoad;

  void fetchUserList() async {
    await FireStoreUser().getUsers().then((docs) {
      docs.forEach((doc) {
        UserModel data = doc.data() as UserModel;
        _userList.add(data);
      });
    });
    _isLoad = false;
    notifyListeners();
  }
}
