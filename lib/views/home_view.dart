import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/home_viewmodel.dart';
import 'package:flutter_firebase_chat/widgets/current_user_info.dart';
import 'package:flutter_firebase_chat/widgets/loader.dart';
import 'package:flutter_firebase_chat/widgets/profile_tile.dart';
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
              toolbarHeight: 80.0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: CurrentUserInfo(
                userName: vm.currentUser.name,
                userProfile: vm.currentUser.profileImg,
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_applications_outlined)),
              ],
              actionsIconTheme: const IconThemeData(color: Colors.black),
            ),
            body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 16.0,
                        ),
                        fillColor: Colors.grey.shade200,
                        hintText: "검색",
                        hintStyle: const TextStyle(fontSize: 14.0)),
                  ),
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
