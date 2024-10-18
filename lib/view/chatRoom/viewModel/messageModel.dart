import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String content;
  String type;
  int timestamp;
  MessageStatus status; // Add this field

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.status, // Include status in the constructor
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      content: doc['content'],
      type: doc['type'],
      timestamp: doc['timestamp'],
      status:
          MessageStatus.values[doc['status']], // Map Firestore value to enum
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type' : type,
      'timestamp': timestamp,
      'status': status.index, // Save the status index to Firestore
    };
  }
}

enum MessageStatus { notDelivered, delivered, seen } // Define the enum
