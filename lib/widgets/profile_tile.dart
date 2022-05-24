import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
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
