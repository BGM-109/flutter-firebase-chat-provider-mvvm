import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/views/chat_view.dart';
import 'package:flutter_firebase_chat/views/home_view.dart';

class ControlViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget? currentView() {
    switch (_currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const ChatView();
      case 2:
        return const Center(
          child: Text("404 PAGE"),
        );
      case 3:
        return const Center(
          child: Text("404 PAGE"),
        );
      default:
        return Container();
    }
  }
}
