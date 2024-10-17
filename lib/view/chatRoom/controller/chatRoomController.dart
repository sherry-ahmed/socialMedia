import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/services/imports.dart';

class Chatroomcontroller extends GetxController {
  RxList<Message> unseen = <Message>[].obs;
  RxString passedchatroomId = ''.obs;
  StreamSubscription<QuerySnapshot>? _seensubscription;
  StreamSubscription<QuerySnapshot>? _messageSubscription;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log('chatController initialized');
  }

 @override
  void onClose() {
    log('onclosed call');
    super.onClose();
    // Cancel the Firestore listener when the controller is closed
    _seensubscription?.cancel();
    _messageSubscription?.cancel();
    
    super.onClose();
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   log('ondispose call');
  //    _messageSubscription?.cancel();
  //    _seensubscription?.cancel();
  // }

  void markMessagesAsSeen(String chatroomId) {
    // Listen for messages where status is "delivered" or "notDelivered" and receiverId matches the current user
    _seensubscription = firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .where('status', whereIn: [
          MessageStatus.delivered.index,
          MessageStatus.notDelivered.index
        ]) // Condition for status
        .where('receiverId',
            isEqualTo:
                Sessioncontroller.userid.toString()) // Condition for receiverId
        .snapshots()
        .listen((snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            // Loop through each document (message) that matches the condition
            for (var doc in snapshot.docs) {
              // Message message = Message.fromDocument(doc);
              // log("Processing message ID: ${doc.id} with status: ${message.status}");

              // // Check if the message's status is 'delivered' or 'notDelivered'
              // if (message.status == MessageStatus.delivered ||
              //     message.status == MessageStatus.notDelivered) {
                // Update the status to "seen" in Firestore for each message
                await firestore
                    .collection('chatrooms')
                    .doc(chatroomId)
                    .collection('messages')
                    .doc(doc
                        .id) // Using the message ID from Firestore to update the correct document
                    .update({'status': MessageStatus.seen.index});

                log("Message with ID ${doc.id} marked as seen.");
              }
            
          } else {
            Utils.toastMessage('No messages to mark as seen');
          }
        });
  }

 




  RxBool isMessageSent = true.obs;

//   RxBool finish = false.obs;

//   updatecounter() {
//     counter++;
//   }
  RxList<Message> messagesList = <Message>[].obs;
  int messageLimit = 10;
  int counter = 1;
  DocumentSnapshot? lastDocument;
  RxBool hasMoreMessages = true.obs;
//   void listenToMessages(String chatroomId, String receiverUID) {
//   var query = _firestore
//       .collection('chatrooms')
//       .doc(chatroomId)
//       .collection('messages')
//       .orderBy('timestamp', descending: false)
//       .limit(messageLimit);

//   if (lastDocument != null) {

//     query = query.startAfterDocument(lastDocument!);

//   }

//   query.snapshots().listen((snapshot) {
//     if (snapshot.docs.isNotEmpty) {
//       //List<Message> newMessages = [];

//       for (var doc in snapshot.docs) {
//         Message message = Message.fromDocument(doc);
//          if (!messagesList.any((m) => m.timestamp == message.timestamp)) {
//           messagesList.insert(0,  message);
//         }
//       }

//       //messagesList.addAll(newMessages.reversed);
//       lastDocument = snapshot.docs.last;
//       resetUnreadMessageCount(chatroomId, Sessioncontroller.userid.toString());
//       hasMoreMessages.value = snapshot.docs.length == messageLimit;

//      } else {
//       // No messages found
//       hasMoreMessages.value = false;
//     }
//   });
// }
  RxBool finish = false.obs;

  updatecounter() {
    counter++;
  }

  void listenToMessages(String chatroomId, receiverUID) {
   _messageSubscription = firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit((messageLimit * counter) + 1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        messagesList.clear();
        for (var doc in snapshot.docs) {
          Message message = Message.fromDocument(doc);
          messagesList.add(message);
        }
        
        hasMoreMessages.value =
            snapshot.docs.length == ((messageLimit * counter) + 1);
      } else {
        // No messages found
        hasMoreMessages.value = false;
      }
    });
  }

  List<Message> get reversedMessagesList => messagesList.reversed.toList();

  Future<void> sendMessage(String chatroomId, String senderUID,
      String receiverUID, String content) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // Create a new message object
    Message message = Message(
      senderId: senderUID,
      receiverId: receiverUID,
      content: content,
      timestamp: timestamp,
      status: MessageStatus.notDelivered, // Set initial status
    );

    // Define message reference
    final messagesRef = firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .doc(timestamp.toString());

    try {
      // First, upload the message
      await messagesRef.set(message.toMap());

      log('Message sent successfully');
      await confirmMessageDelivery(chatroomId, timestamp.toString());

      // After the message is sent, update the unread message count
      await updateUnreadMessageCount(chatroomId, receiverUID);

      // Indicate that the message was sent
      isMessageSent.value = true;
    } catch (error) {
      log('Error sending message: $error');
      isMessageSent.value = false;
    }
  }

  Future<void> confirmMessageDelivery(
      String chatroomId, String messageId) async {
    try {
      await firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('messages')
          .doc(messageId)
          .update({'status': MessageStatus.delivered.index});

      log('Message delivery confirmed');
    } catch (e) {
      log('Error confirming delivery: $e');
    }
  }

  Future<void> updateUnreadMessageCount(
      String chatroomId, String receiverUID) async {
    final participantsRef = firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('participants')
        .doc(receiverUID);

    try {
      await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(participantsRef);

        if (snapshot.exists) {
          int currentCount = snapshot['unreadMessageCount'] ?? 0;
          int newCount = currentCount + 1;

          transaction.update(participantsRef, {
            'unreadMessageCount': newCount,
          });
        } else {
          transaction.set(participantsRef, {
            'unreadMessageCount': 1,
          });
        }
      });

      log('Unread message count updated successfully');
    } catch (error) {
      log('Error updating unread message count: $error');
    }
  }

  Future<void> resetUnreadMessageCount(
      String chatroomId, String receiverUID) async {
    try {
      await firestore
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

// Future<void> markMessagesAsSeen(String chatroomId, List<Message> messages) async {
//   final batch = _firestore.batch();

//   for (var message in messages) {
//     if (message.status == MessageStatus.delivered) {
//       batch.update(
//         _firestore
//             .collection('chatrooms')
//             .doc(chatroomId)
//             .collection('messages')
//             .doc(message.timestamp.toString()),
//         {'status': MessageStatus.seen.index},
//       );
//     }
//   }

//   try {
//     await batch.commit();
//     log('Messages marked as seen');
//   } catch (e) {
//     log('Error marking messages as seen: $e');
//   }
// }

   var isFriend = true.obs;

  // void checkFriendship(String currentUserId, String friendUserId) {
  //   isFriendStream(currentUserId, friendUserId).listen((isFriendStatus) {
  //     isFriend.value = isFriendStatus;
  //   });
  // }

  // Stream<bool> isFriendStream(String currentUserId, String friendUserId) {
  //   return FirebaseFirestore.instance
  //       .collection('FriendSystem')
  //       .doc(currentUserId)
  //       .collection('friends')
  //       .doc(friendUserId)
  //       .snapshots()
  //       .map((docSnapshot) => docSnapshot.exists);
  // }
}
