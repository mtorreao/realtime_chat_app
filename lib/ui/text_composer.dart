import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
              IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () async {
                    var user = await AuthService().handleSignIn();
                    var file =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                    if (file == null) return;
                    StorageUploadTask task = FirebaseStorage.instance
                        .ref()
                        .child(user.uid.toString() +
                        DateTime
                            .now()
                            .millisecondsSinceEpoch
                            .toString())
                        .putFile(file);
                    var snapshot = await task.onComplete;
                    String imgUrl = await snapshot.ref.getDownloadURL();
                    _sendMessage(imageUrl: imgUrl);
                  }),
              Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(
                        labelText: 'Enviar uma mensagem...'),
                  )),
              IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
            ],
          )),
    );
  }

  Future _sendMessage({String imageUrl}) async {
    var messageText = _messageTextController.text;

    var user = await AuthService().handleSignIn();
    if (messageText.isNotEmpty || imageUrl.isNotEmpty) {
      try {
        _messageTextController.text = '';
        await Firestore.instance.collection('realtime_chat_app_messages').add(
            Message(
                senderName: user.displayName,
                text: messageText ?? null,
                imgUrl: imageUrl ?? null,
                senderPhotoUrl: user.photoUrl)
                .toMap());
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
