class Message {
  String id;
  String text;
  String sender;
  DateTime createdDate;

  Message({this.text, this.sender});

  toMap() {
    var map = Map();
    map['id'] = id;
    map['text'] = text;
    map['sender'] = sender;
    map['createdDate'] = createdDate;
    return map;
  }

  static Message fromMap(Map<String, dynamic> map) {
    var message = Message();
    message.text = map['text'];
    message.text = map['sender'];
    return message;
  }
}
