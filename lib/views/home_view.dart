import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return vm.isLoad
        ? const Center(
            child: CircularProgressIndicator(color: Colors.black,),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("연락처"),
            ),
            body: ListView(children: [
              SizedBox(
                height: 32.0,
              ),
              ...vm.userList
                  .map((user) => ProfileTile(
                        user: user,
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
  }) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
