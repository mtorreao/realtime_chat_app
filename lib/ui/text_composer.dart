import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
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
          IconButton(icon: Icon(Icons.send), onPressed: null),
        ],
      )),
    );
  }
}
