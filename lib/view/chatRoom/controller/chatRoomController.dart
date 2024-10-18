import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Chatroomcontroller extends GetxController {
  RxList<Message> unseen = <Message>[].obs;
  RxString passedchatroomId = ''.obs;
  StreamSubscription<QuerySnapshot>? seensubscription;
  StreamSubscription<QuerySnapshot>? messageSubscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  File? imageFile;
  @override
  void onInit() {
    super.onInit();
    log('chatController initialized');
  }

  @override
  void onClose() {
    log('onclosed call');
    super.onClose();
    seensubscription?.cancel();
    seensubscription = null;
    messageSubscription?.cancel();
    messageSubscription = null;

    super.onClose();
  }

  void markMessagesAsSeen(String chatroomId) {
    seensubscription = firestore
        .collection('chatrooms')
        .doc(chatroomId)
        .collection('messages')
        .where('status', whereIn: [
          MessageStatus.delivered.index,
          MessageStatus.notDelivered.index
        ]) // Condition for status
        .where('receiverId', isEqualTo: Sessioncontroller.userid.toString())
        .snapshots()
        .listen((snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            for (var doc in snapshot.docs) {
              await firestore
                  .collection('chatrooms')
                  .doc(chatroomId)
                  .collection('messages')
                  .doc(doc.id)
                  .update({'status': MessageStatus.seen.index});

              log("Message with ID ${doc.id} marked as seen.");
            }
          } else {
            log('No messages to mark as seen');
          }
        });
  }

  RxBool isMessageSent = true.obs;

  RxList<Message> messagesList = <Message>[].obs;
  int messageLimit = 10;
  int counter = 1;
  DocumentSnapshot? lastDocument;
  RxBool hasMoreMessages = true.obs;

  RxBool finish = false.obs;

  updatecounter() {
    counter++;
  }

  void listenToMessages(String chatroomId, receiverUID) {
    messageSubscription = firestore
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
      String receiverUID, String content, String type) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // Create a new message object
    Message message = Message(
      senderId: senderUID,
      receiverId: receiverUID,
      content: content,
      timestamp: timestamp,
      type: type,
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
  var isuploading = false.obs;

  Future<void> pickImage(ImageSource source, String chatroomId,
      String senderUID, String receiverUID, String content, String type) async {
        
    final String? imagePath = await Services.pickImage(source);
    if (imagePath != null) {
      isuploading.value = true;
      imageFile = File(imagePath);
      final String? newUrl = await Services.sendImage(imagePath, chatroomId);
      isuploading.value = false;
      if (newUrl != null) {
        await sendMessage(chatroomId, senderUID, receiverUID, newUrl, type);
        
      } else {
        log('unable to send image');
        isuploading.value = false;
      }
      update();
    }
  }
  Future<void> decrementUnreadMessageCount(
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
          int newCount = currentCount -1;

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
  Future<void> deleteMessage(String chatroomId, Message messsage) async {
    try {
      // Reference to the message document
      final messageRef = firestore
          .collection('chatrooms')
          .doc(chatroomId)
          .collection('messages')
          .doc(messsage.timestamp.toString());
          if(messsage.status == MessageStatus.delivered || messsage.status==MessageStatus.notDelivered){
            decrementUnreadMessageCount(chatroomId, messsage.receiverId);
          }

      // Delete the message document
      await messageRef.delete();
      log('Message deleted successfully');
    } catch (error) {
      log('Error deleting message: $error');
    }
  }
void showDeleteConfirmationDialog(BuildContext context, String chatroomId, Message message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Message'),
        content: Text('Do you want to delete this message?',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog without doing anything
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Call the delete message function
              await deleteMessage(chatroomId, message);
              // Close the dialog
              Get.back();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
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
