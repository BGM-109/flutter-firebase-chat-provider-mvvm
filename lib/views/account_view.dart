import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/account_viewmodel.dart';
import 'package:flutter_firebase_chat/widgets/loader.dart';
import 'package:flutter_firebase_chat/widgets/user_info_box.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nickName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: vm.isLoad
            ? Loader(msg: vm.loadMsg)
            : Center(
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
                        validator: (value) {
                          if (value != null && value.length < 2) {
                            return "닉네임은 2글자 이상 입력해주세요";
                          } else if (value != null &&
                              value == vm.currentUser.name) {
                            return "다른 닉네임을 넣어 주세요";
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
                            final bool isValid =
                                _formKey.currentState!.validate();
                            if (isValid) {
                              vm.changeUserName(nickName);
                              _formKey.currentState!.reset();
                            }
                          },
                          child: const Text("변경하기")),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
