import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/control_viewmodel.dart';
import 'package:provider/provider.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ControlViewModel>();
    return Scaffold(
      body: vm.currentView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedItemColor: Colors.black,
        currentIndex: vm.currentIndex,
        onTap: vm.changeIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: '대화',
              activeIcon: Icon(Icons.chat)),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined),
              label: '타임라인',
              activeIcon: Icon(Icons.access_time_filled)),
          BottomNavigationBarItem(
              icon: Icon(Icons.call_outlined),
              label: '통화',
              activeIcon: Icon(Icons.call)),
        ],
      ),
    );
  }
}
