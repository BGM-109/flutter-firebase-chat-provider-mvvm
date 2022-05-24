import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountViewModel extends ChangeNotifier {
  AccountViewModel() {
    initUser();
  }

  final String _currentUserId = "gn3jZorLmdhqN9KzEva8";

  UserModel _currentUser = UserModel(name: "test", profileImg: "", id: "test");

  UserModel get currentUser => _currentUser;

  bool isLoad = true;

  String loadMsg = "유저 정보를 불러오고 있습니다.";

  void changeUserName(String name) async {
    loadMsg = "유저 정보를 변경 중 입니다.";
    isLoad = true;
    notifyListeners();

    FireStoreUser().updateUserNameFromId(_currentUserId, name);
    var doc = await FireStoreUser().getUserFromId(_currentUserId);
    _currentUser = doc.data() as UserModel;
    isLoad = false;
    notifyListeners();

    Fluttertoast.showToast(msg: "닉네임이 변경되었어요", backgroundColor: Colors.grey);
  }

  void initUser() async {
    var doc = await FireStoreUser().getUserFromId(_currentUserId);
    _currentUser = doc.data() as UserModel;
    isLoad = false;
    notifyListeners();
  }
}
