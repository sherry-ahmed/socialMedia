import 'package:socialmedia/baseComponents/imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Chatroomcontroller extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Message> messagesList =
      <Message>[].obs; 
  RxBool isMessageSent = true.obs; 
  var counter = 0;

  void listenToMessages(String chatroomId) {
    _firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp',
            descending: false)
        .snapshots()
        .listen((snapshot) {
      messagesList.clear();
      for (var doc in snapshot.docs) {
        Message message = Message.fromDocument(doc);
        messagesList.add(message);
      }
      resetUnreadMessageCount(chatroomId, Sessioncontroller.userid.toString());
    });
  }

  List<Message> get reversedMessagesList =>
      messagesList.reversed.toList(); 


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
      isMessageSent.value = true;
      DocumentSnapshot snapshot = await _firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('participants')
          .doc(receiverUID)
          .get();
      if (snapshot.exists) {

        counter = snapshot.get('unreadMessageCount');

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
      
    }).onError((error, stackTrace) {
      log('check your internet');
    });
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
      log("Failed to reset unread message count: $e");
    }
  }
}
