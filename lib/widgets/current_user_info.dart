import 'package:flutter/material.dart';

class CurrentUserInfo extends StatelessWidget {
  const CurrentUserInfo({
    Key? key,
    required this.userName,
    required this.userProfile,
  }) : super(key: key);

  final String userName;
  final String userProfile;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: NetworkImage(userProfile),
        radius: 24.0,
      ),
      const SizedBox(
        width: 12.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: const TextStyle(color: Colors.black, fontSize: 14.0),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(24.0)),
              child: Text(
                "Keep",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 9.0),
              ))
        ],
      ),
    ]);
  }
}
