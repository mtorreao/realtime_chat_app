import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/ui/chat_message.dart';
import 'package:realtime_chat_app/ui/text_composer.dart';
import 'package:realtime_chat_app/util/message.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Message> _messageList = List();

  @override
  void initState() {
    super.initState();

    Firestore.instance
        .collection('realtime_chat_messages')
        .snapshots()
        .listen((snapshot) {
      _messageList.clear();

      setState(() {
        for (var document in snapshot.documents) {
          var data = document.data;
          print(data);
          Message message = Message.fromMap(data);
          _messageList.add(message);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Realtime Chat'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: StreamBuilder(
                stream: Firestore.instance.collection(
                    'realtime_chat_app_messages').snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return ChatMessage(
                                snapshot.data.documents[index].data);
                          });
                  }
                })),
            Divider(
              height: 1.0,
            ),
            Container(
                decoration: BoxDecoration(color: Theme
                    .of(context)
                    .cardColor),
                child: TextComposer())
          ],
        ),
      ),
    );
  }
}
