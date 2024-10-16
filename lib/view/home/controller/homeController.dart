import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Homecontroller extends GetxController {
  RxBool showsearchbar = false.obs;
  final friendController = Get.find<FriendController>();
  var isloading = false;
    var friendList = <UserModel>[].obs; // List of UIDs of friends
    @override
  void onInit() {
   
    super.onInit();
    listenToFriends(Sessioncontroller.userid.toString());
    log('called');
  }

 void listenToFriends(String userUID) {
  log('listening starts');
  try {
    isloading = true; // Start loading
    update();

    _firestore
        .collection('FriendSystem')
        .doc(userUID)
        .collection('friends')
        .snapshots()
        .listen(
      (snapshot) {
        // Clear the existing friend list before updating
        friendList.clear();

        for (var doc in snapshot.docs) {
          // Extract and map the data to UserModel
          var requestData = doc.data();
          UserModel userModel = UserModel.fromMap(requestData['data']);
          // Add the new friend to the observable list
          friendList.add(userModel);
        }

        log(friendList.toString());

        // Stop loading when the first batch of data is loaded
        isloading = false;
        update();
      },
      onError: (error) {
        // Handle any errors here and stop loading
        isloading = false;
        log("Error listening to friends: $error");
        update();
      },
    );
  } catch (e) {
    // Catch and handle any errors that may occur
    log("Exception in listenToFriends: $e");
    isloading = false;
    update(); // Stop loading in case of an exception
  }
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
