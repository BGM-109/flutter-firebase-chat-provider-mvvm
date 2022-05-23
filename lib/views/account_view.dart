import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/account_viewmodel.dart';
import 'package:flutter_firebase_chat/widgets/user_info_box.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final _formKey = GlobalKey<FormState>();
  String nickName = "";

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountViewModel>();
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserInfoBox(um: vm.currentUser),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    labelText: "닉네임변경",
                    border: OutlineInputBorder()),
                validator: (nickName) {
                  if (nickName != null && nickName.length < 2) {
                    return "닉네임은 2글자 이상 입력해주세요";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  nickName = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    final bool isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      vm.changeUser(nickName);
                    }
                  },
                  child: const Text("변경하기")),
            ],
          ),
        ),
      ),
    );
  }
}
