import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat_message_model.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_detail_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key, required this.roomId, required this.peerId})
      : super(key: key);
  final String roomId;
  final String peerId;

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  String _content = "";
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  String peerProfileImg =
      "https://firebasestorage.googleapis.com/v0/b/flutter-firebase-chat-mvvm.appspot.com/o/20201110160126516.jpeg?alt=media&token=bc979b27-5e0a-494c-8aaf-f93c9ae2a8ca";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var doc = await FireStoreUser().getUserFromId(widget.peerId);
      UserModel peer = doc.data() as UserModel;
      peerProfileImg = peer.profileImg;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatDetailViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("채팅방"),
        ),
        body: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: vm.getMessages(widget.roomId),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var listMessages = snapshot.data!.docs;
                    if (listMessages.isNotEmpty) {
                      return ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: snapshot.data?.docs.length,
                          reverse: true,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            const currentUserId = "gn3jZorLmdhqN9KzEva8";
                            const currentUserProfile =
                                "https://firebasestorage.googleapis.com/v0/b/flutter-firebase-chat-mvvm.appspot.com/o/20201110160126516.jpeg?alt=media&token=bc979b27-5e0a-494c-8aaf-f93c9ae2a8ca";
                            String profileImg = currentUserId ==
                                    snapshot.data?.docs[index]["idFrom"]
                                ? currentUserProfile
                                : peerProfileImg;
                            return MessageBox(
                              content: snapshot.data?.docs[index]["content"],
                              idTo: snapshot.data?.docs[index]["idTo"],
                              idFrom: snapshot.data?.docs[index]["idFrom"],
                              profileImg: profileImg,
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('메세지가 없습니다.'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                },
              ),
            ),
            TextField(
              controller: _textEditingController,
              onChanged: (text) {
                _content = text;
              },
              onSubmitted: (value) {
                if (_content.trim().isNotEmpty) {
                  vm.sendMessage(_content, 1, widget.roomId,
                      "gn3jZorLmdhqN9KzEva8", widget.peerId);
                  _textEditingController.clear();
                  _scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                } else {
                  Fluttertoast.showToast(
                      msg: '메세지를 입력해주세요', backgroundColor: Colors.grey);
                }
              },
            )
          ],
        ));
  }
}

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
      Text(content),
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
