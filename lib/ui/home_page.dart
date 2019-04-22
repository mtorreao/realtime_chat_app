import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Message> _messageList = List();

  @override
  void initState() {
    super.initState();

    _messageList.add(Message(text: 'ABC', sender: 'Eu'));
    _messageList.add(Message(text: 'DEF', sender: 'Você'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Realtime Chat'),
        ),
        body: Column(
          children: <Widget>[
            ListView.builder(
                itemCount: _messageList.length,
                itemBuilder: (context, index) {
                  var message = _messageList[index];
                  return Text(_messageList[index].text);
                }),
          ],
        ));
  }
}

class Message {
  String id;
  String text;
  String sender;
  DateTime createdDate;

  Message({this.text, this.sender});
}
