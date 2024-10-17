import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/services/imports.dart';

class Homecontroller extends GetxController {
  RxBool showsearchbar = false.obs;
  final friendController = Get.find<FriendController>();
  var isloading = false.obs;
  var friendList = <UserModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    listenToFriends(Sessioncontroller.userid.toString());
    log('called');
  }

  void listenToFriends(String userUID) {
    log('Listening starts');
    try {
      isloading.value = true;
      update();

      _firestore
          .collection('FriendSystem')
          .doc(userUID)
          .collection('friends')
          .snapshots()
          .listen(
        (snapshot) {
          friendList.clear();

          for (var doc in snapshot.docs) {
            var requestData = doc.data();

            if (requestData.containsKey('data')) {
              UserModel userModel = UserModel.fromMap(requestData['data']);
              friendList.add(userModel);
            } else {
              log("Document does not contain 'data' field");
            }
          }

          log("Friend list: ${friendList.toString()}");

          isloading.value = false;
          update();
        },
        onError: (error) {
          isloading.value = false;
          log("Error listening to friends: ${error.toString()}");
          update();
        },
      );
    } catch (e) {
      log("Exception in listenToFriends: $e");
      isloading.value = false;
      update();
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
        .map((snapshot) => snapshot['unreadMessageCount']);
  }
}
