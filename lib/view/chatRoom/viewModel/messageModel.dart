import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String content;
  int timestamp;
  MessageStatus status; // Add this field

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.status, // Include status in the constructor
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      senderId: doc['senderId'],
      receiverId: doc['receiverId'],
      content: doc['content'],
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
      'timestamp': timestamp,
      'status': status.index, // Save the status index to Firestore
    };
  }
}

enum MessageStatus { notDelivered, delivered, seen } // Define the enum
