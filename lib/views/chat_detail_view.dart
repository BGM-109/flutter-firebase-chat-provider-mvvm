import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/user_model.dart';
import 'package:flutter_firebase_chat/service/firestore_user.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_detail_viewmodel.dart';
import 'package:flutter_firebase_chat/widgets/message_box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_chat/constants.dart' as constants;

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
  String peerProfileImg = "";
  String peerName = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var doc = await FireStoreUser().getUserFromId(widget.peerId);
      UserModel peer = doc.data() as UserModel;
      peerProfileImg = peer.profileImg;
      peerName = peer.name;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatDetailViewModel>();
    return Scaffold(
        backgroundColor: Colors.blueAccent.shade100,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            peerName,
          ),
          titleSpacing: 0,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18.0),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_outlined)),
          ],
          actionsIconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
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
                            String profileImg = constants.CURRENT_USER_ID ==
                                    snapshot.data?.docs[index]["idFrom"]
                                ? constants.CURRENT_USER_PROFILE_IMG
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
                        child: Text('???????????? ????????????.'),
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
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              width: double.infinity,
              height: 70,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.image_outlined)),
                  Expanded(
                    child: SizedBox(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Aa",
                          suffixIcon: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        controller: _textEditingController,
                        onChanged: (text) {
                          _content = text;
                        },
                        onSubmitted: (value) {
                          if (_content.trim().isNotEmpty) {
                            vm.sendMessage(_content, 1, widget.roomId,
                                constants.CURRENT_USER_ID, widget.peerId);
                            _textEditingController.clear();
                            _scrollController.animateTo(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut);
                          } else {
                            Fluttertoast.showToast(
                                msg: '???????????? ??????????????????',
                                backgroundColor: Colors.grey);
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mic_none_outlined)),
                ],
              ),
            )
          ],
        ));
  }
}
