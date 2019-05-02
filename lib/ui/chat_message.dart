import 'package:flutter/material.dart';
import 'package:realtime_chat_app/util/message.dart';

class ChatMessage extends StatelessWidget {

  final Message message;

  ChatMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: message.senderPhotoUrl != null ? NetworkImage(
                  message.senderPhotoUrl) : AssetImage(
                  'images/Upside-Down_Face_Emoji.png'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.senderName,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(message.createdDate != null ? message.sendAt() : '',
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption),
                Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: message.imgUrl != null ?
                    Image.network(message.imgUrl, width: 250.0,) :
                    Text(message.text, style: Theme
                        .of(context)
                        .textTheme
                        .body1,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
