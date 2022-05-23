import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';

class UserInfoBox extends StatelessWidget {
  const UserInfoBox({
    Key? key,
    required this.um,
  }) : super(key: key);

  final UserModel um;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(um.profileImg),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            um.name,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
