import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {Key? key,
      required this.content,
      required this.idTo,
      required this.idFrom,
      required this.profileImg})
      : super(key: key);
  final String content;
  final String idTo;
  final String idFrom;
  final String profileImg;

  @override
  Widget build(BuildContext context) {
    const currentUserId = "gn3jZorLmdhqN9KzEva8";
    List<Widget> children = [
      Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
              color: currentUserId == idTo
                  ? Colors.white
                  : Colors.lightGreenAccent,
              borderRadius: BorderRadius.circular(16.0)),
          child: Text(content)),
      const SizedBox(
        width: 12.0,
      ),
      CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage: NetworkImage(profileImg),
        radius: 20.0,
      )
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: currentUserId == idTo
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: currentUserId == idTo ? children.reversed.toList() : children,
      ),
    );
  }
}
