import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/viewmodels/chat_detail_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({Key? key}) : super(key: key);

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  String _content = "";
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

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
                stream: vm.getMessages("test"),
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
                          itemBuilder: (context, index) =>
                              MessageBox(doc: snapshot.data?.docs[index]));
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
                  vm.sendMessage(_content);
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
  const MessageBox({Key? key, required this.doc}) : super(key: key);
  final QueryDocumentSnapshot? doc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(doc!["content"].toString()), const CircleAvatar()],
    );
  }
}
