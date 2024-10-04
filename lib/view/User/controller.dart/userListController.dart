import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Userlistcontroller extends GetxController{

bool showsearchbar = false;
   searchbar(value){
    showsearchbar = value;
    update();
  }
  rebuild(){
    update();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Function to get unread message count for a specific user in the chatroom
Stream<int> getUnreadMessageCount(String chatroomId, String userId) {
  return _firestore
      .collection('chatrooms')
      .doc(chatroomId)
      .collection('participants')
      .doc(userId)
      .snapshots()
      .map((snapshot) => snapshot['unreadMessageCount'] ?? 0);
}

}