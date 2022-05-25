import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_room.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:flutter_firebase_chat/constants.dart' as constants;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    fetchUserList();
  }

  UserModel _currentUser = UserModel(name: "", profileImg: "", id: "");

  UserModel get currentUser => _currentUser;

  final List<UserModel> _userList = [];

  List<UserModel> get userList => _userList;

  bool _isLoad = true;

  bool get isLoad => _isLoad;

  Future<void> fetchUserList() async {
    await FireStoreUser().getUsers().then((docs) {
      docs.forEach((doc) {
        UserModel data = doc.data() as UserModel;
        if (data.id == constants.CURRENT_USER_ID) {
          _currentUser = data;
        } else {
          _userList.add(data);
        }
      });
    }).then((value) {
      _isLoad = false;
      notifyListeners();
    });
  }

  void onTapUser(String userId, BuildContext context) {
    List<String> members = [userId, constants.CURRENT_USER_ID];
    FireStoreRoom().findRoom(members, context, userId);
  }
}