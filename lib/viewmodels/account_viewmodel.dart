import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';

class AccountViewModel extends ChangeNotifier {
  final UserModel _currentUser = UserModel("조바이든", "123");

  UserModel get currentUser => _currentUser;
}
