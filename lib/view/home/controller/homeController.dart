import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/friendController.dart';

class Homecontroller extends GetxController {
  RxBool showsearchbar = false.obs;
  final FriendController friendController = Get.put(FriendController());
  @override
  void onInit() {
    super.onInit();
    friendController.listenToFriends(Sessioncontroller.userid.toString());
  }

  searchbar(value) {
    showsearchbar.value = value;
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
