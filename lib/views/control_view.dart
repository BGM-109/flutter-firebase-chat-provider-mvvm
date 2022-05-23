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
        currentIndex: vm.currentIndex,
        onTap: vm.changeIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: '연락처',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '유저정보',
          ),
        ],
      ),
    );
  }
}
