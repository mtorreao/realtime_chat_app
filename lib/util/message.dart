class Message {
  String id;
  String text;
  String senderName;
  DateTime createdDate;

  Message({this.text, this.senderName}) {
    createdDate = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['text'] = text;
    map['senderName'] = senderName;
    map['createdDate'] = createdDate;
    return map;
  }

  static Message fromMap(Map<String, dynamic> map) {
    var message = Message();
    message.text = map['text'];
    message.senderName = map['senderName'];
    return message;
  }
}
