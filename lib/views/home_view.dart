import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return vm.isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: vm.userList.map((user) => Text(user.name)).toList(),
          );
  }
}
