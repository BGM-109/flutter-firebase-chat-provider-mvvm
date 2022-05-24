import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/viewmodels/home_viewmodel.dart';
import 'package:flutter_firebase_chat/views/chat_detail_view.dart';
import 'package:flutter_firebase_chat/widgets/loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return vm.isLoad
        ? const Loader(msg: "유저 정보를 불러오고 있습니다.")
        : Scaffold(
            appBar: AppBar(
              title: const Text("연락처"),
            ),
            body: ListView(children: [
              const SizedBox(
                height: 32.0,
              ),
              ...vm.userList
                  .map((user) => ProfileTile(
                        user: user,
                        onTap: () {
                          vm.onTapUser(user.id, context);
                        },
                      ))
                  .toList(),
            ]),
          );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);
  final UserModel user;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profileImg),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(user.name),
            const Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
