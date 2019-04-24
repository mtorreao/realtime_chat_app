import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat_app/util/auth_service.dart';
import 'package:realtime_chat_app/util/message.dart';

class TextComposer extends StatefulWidget {

  TextComposer();

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  var _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.photo_camera), onPressed: null),
              Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(labelText: 'Enviar uma mensagem...'),
                  )),
              IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
            ],
          )),
    );
  }

  Future _sendMessage() async {
    var messageText = _messageTextController.text;

    var user = await AuthService().handleSignIn();
    if (messageText.isNotEmpty) {
      try {
        await Firestore.instance
            .collection('realtime_chat_app_messages')
            .add(Message(senderName: user.displayName,
            text: messageText,
            senderPhotoUrl: user.photoUrl).toMap());
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Mensagem enviada!'),
          duration: Duration(seconds: 2),
        ));
      } catch (e) {
        print(e);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao enviar mensagem'),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
}


