import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/view/chatRoom/viewModel/messageModel.dart';

class Chatroomcontroller extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Message> messagesList =
      <Message>[].obs; // Store chat messages as a list of Message objects
  RxBool isMessageSent = true.obs; // Track message sent status
  var counter = 0;

  // Fetch messages for the chatroom between sender and receiver
  void listenToMessages(String chatroomId) {
    _firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp',
            descending: false) // Keep the order ascending in Firestore
        .snapshots()
        .listen((snapshot) {
      messagesList.clear();
      for (var doc in snapshot.docs) {
        Message message = Message.fromDocument(doc);
        messagesList.add(message);
      }
      resetUnreadMessageCount(chatroomId, Sessioncontroller.userid.toString());
      //isMessageSent.value = true;
    });
  }

  // Getter to reverse the message list for the UI
  List<Message> get reversedMessagesList =>
      messagesList.reversed.toList(); // Reverse the list here

  // Function to send a message
  // Function to send a message
  Future<void> sendMessage(String chatroomId, String senderUID,
      String receiverUID, String content) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    Message message = Message(
      senderId: senderUID,
      receiverId: receiverUID,
      content: content,
      timestamp: timestamp,
    );

    // Reset the flag before sending the message
    isMessageSent.value = false;

    await _firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .doc(timestamp.toString())
        .set(message.toMap())
        .then((value) async {
      log('message sent');
      DocumentSnapshot snapshot = await _firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('participants')
          .doc(receiverUID)
          .get();
      if (snapshot.exists) {
        // Get the unreadMessageCount field and store it in a variable
        counter = snapshot.get('unreadMessageCount');

        // Do something with the value (e.g., store in a state variable or use it)
        log('Unread Message Count: $counter');
      } else {
        await _firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('participants')
          .doc(receiverUID)
          .set({
        'unreadMessageCount': FieldValue.increment(0),
      }).then((value) {
        log('document does not exit so counter set to zero on later function it will be incremented counter updated');
      }).onError((error, stacktrace) {
        log('counter not updated');
      });
        log('Document does not exist');
      }

      await _firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('participants')
          .doc(receiverUID)
          .set({
        'unreadMessageCount': FieldValue.increment(counter + 1),
      }).then((value) {
        log('counter updated');
      }).onError((error, stacktrace) {
        log('counter not updated');
      });
      isMessageSent.value = true;
    }).onError((error, stackTrace) {
      log('check your internet');
    });
    // After sending the message, increment the unread message counter for the receiver

    // Set isMessageSent to true after message is successfully uploaded
  }

  Future<void> resetUnreadMessageCount(
      String chatroomId, String receiverUID) async {
    try {
      await _firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('participants')
          .doc(receiverUID)
          .update({
        'unreadMessageCount': 0,
      });
    } catch (e) {
      print("Failed to reset unread message count: $e");
    }
  }

  // Create a chatroom ID using sender and receiver UIDs
}
