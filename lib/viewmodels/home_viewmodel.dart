import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_room.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  void onTapUser(String userId, BuildContext context) {
    if (userId == "gn3jZorLmdhqN9KzEva8") {
      Fluttertoast.showToast(msg: "본인입니다.");
    } else {
      List<String> members = [userId, "gn3jZorLmdhqN9KzEva8"];
      FireStoreRoom().findRoom(members, context, userId);
    }
  }
}
