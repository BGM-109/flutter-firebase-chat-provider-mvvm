import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_viewmodel.dart';
import 'package:flutter_firebase_chat/views/chat_detail_view.dart';
import 'package:flutter_firebase_chat/widgets/search_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_chat/constants.dart' as constants;

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "대화",
        ),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w800, color: Colors.black, fontSize: 24.0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80.0,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.menu_open_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.video_call_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.sms_outlined)),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SearchInput(),
          const SizedBox(
            height: 14.0,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: vm.fetchRooms(constants.CURRENT_USER_ID),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var listRooms = snapshot.data!.docs;
                  if (listRooms.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listRooms.length,
                      itemBuilder: (context, index) {
                        String peerId =
                            snapshot.data!.docs[index]["members"][0];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatDetailView(
                                          roomId: snapshot.data!.docs[index].id,
                                          peerId: peerId)));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.docs[index]["displayImg"]),
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(
                                      "${snapshot.data!.docs[index]["displayName"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )));
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("채팅방이 없습니다."),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
