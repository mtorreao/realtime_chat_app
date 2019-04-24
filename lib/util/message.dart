class Message {
  String id;
  String text;
  String senderName;
  DateTime createdDate;
  String senderPhotoUrl;
  String imgUrl;

  Message({this.text, this.senderName}) {
    createdDate = DateTime.now();
  }

  String sendAt() {
    var today = DateTime.now();
    var differenceInSeconds = (today.millisecondsSinceEpoch -
        createdDate.millisecondsSinceEpoch) / 1000;
    print(differenceInSeconds);
    if (differenceInSeconds >= 3600) {
      return '${(differenceInSeconds / 3600).toStringAsFixed(0)} hours ago';
    } else if (differenceInSeconds >= 60) {
      return '${(differenceInSeconds / 60).toStringAsFixed(0)} minutes ago';
    } else {
      return '${differenceInSeconds.toStringAsFixed(0)} seconds ago';
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['text'] = text;
    map['senderName'] = senderName;
    map['senderPhotoUrl'] = senderPhotoUrl;
    map['createdDate'] = createdDate;
    map['imgUrl'] = imgUrl;
    return map;
  }

  static Message fromMap(Map<String, dynamic> map) {
    var message = Message();
    message.text = map['text'];
    message.senderName = map['senderName'];
    message.createdDate = map['createdDate'];
    message.senderPhotoUrl = map['senderPhotoUrl'];
    message.imgUrl = map['imgUrl'];
    return message;
  }
}
