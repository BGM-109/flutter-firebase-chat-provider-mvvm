import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/account_viewmodel.dart';
import 'package:provider/provider.dart';


class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountViewModel>();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(vm.currentUser.name), TextField()],
      ),
    );
  }
}
