import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String content;
  int timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      content: doc['content'],
      timestamp: doc['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
