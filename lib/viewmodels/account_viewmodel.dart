import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_firebase_chat/constants.dart' as constants;

class AccountViewModel extends ChangeNotifier {
  AccountViewModel() {
    initUser();
  }

  UserModel _currentUser = UserModel(name: "", profileImg: "", id: "");

  UserModel get currentUser => _currentUser;

  bool isLoad = true;

  String loadMsg = "유저 정보를 불러오고 있습니다.";

  void changeUserName(String name) async {
    loadMsg = "유저 정보를 변경 중 입니다.";
    isLoad = true;
    notifyListeners();

    FireStoreUser().updateUserNameFromId(constants.CURRENT_USER_ID, name);
    var doc = await FireStoreUser().getUserFromId(constants.CURRENT_USER_ID);
    _currentUser = doc.data() as UserModel;
    isLoad = false;
    notifyListeners();

    Fluttertoast.showToast(msg: "닉네임이 변경되었어요", backgroundColor: Colors.grey);
  }

  void initUser() async {
    var doc = await FireStoreUser().getUserFromId(constants.CURRENT_USER_ID);
    _currentUser = doc.data() as UserModel;
    isLoad = false;
    notifyListeners();
  }
}
