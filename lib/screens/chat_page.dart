import 'package:chat_app_v_1_0/utils/custom_button.dart';
import 'package:chat_app_v_1_0/widgets/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  static const String id = "CHAT";
  final FirebaseUser user;

  Chat({Key key, this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController(
      initialScrollOffset: 0.0);

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _fireStore.collection('messages').add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': Timestamp.now().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40.0,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: Text('Core Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('messages')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  List<DocumentSnapshot> docs = snapshot.data.documents;

                  Iterable<Message> messages = docs.map((doc) =>
                      Message(
                          from: doc.data['from'],
                          text: doc.data['text'],
                          me: widget.user.email == doc.data['from']));

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages, // ignore: sdk_version_ui_as_code
                    ],
                  );
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: 'Enter Message...',
                        border: OutlineInputBorder(),
                      ),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: 'Send',
                    callback: callback,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

