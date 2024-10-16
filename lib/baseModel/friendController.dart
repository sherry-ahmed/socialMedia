import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class FriendController extends GetxController {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var requestList = <UserModel>[].obs; // List of UIDs of friend requests
  var friendList = <UserModel>[].obs; // List of UIDs of friends
  RxBool requestsent = false.obs;
  var isloading = false;


  // Retrieve friend requests in real-time
  void listenToFriendRequests(String userUID) {
    _firestore
        .collection('FriendSystem')
        .doc(Sessioncontroller.userid)
        .collection('requests')
        .snapshots()
        .listen((snapshot) {
      requestList.clear();
       for (var doc in snapshot.docs) {
        var requestData = doc.data();
        UserModel userModel = UserModel.fromMap(requestData['data']);
        requestList.add(userModel); // Add to observable list
      }
      log(requestList.toString());
    });
  }

  // Retrieve friends in real-time
  


  // Send a friend request
  Future<void> sendFriendRequest(
      String senderUID, String receiverUID, UserModel data) async {
    DocumentSnapshot receiverSnapshot = await _firestore
        .collection('FriendSystem')
        .doc(receiverUID)
        .collection('friends')
        .doc(senderUID)
        .get();
    if (receiverSnapshot.exists) {
      

      Utils.toastMessage('You are already friends with this user');
      // Exit the function if already friends
    } else {
      await _firestore
          .collection('FriendSystem')
          .doc(receiverUID)
          .collection('requests')
          .doc(senderUID)
          .set({
        'senderUID': senderUID,
        'timestamp': FieldValue.serverTimestamp(),
        'data': data.toMap()
      }).then((value) {
        requestsent.value = true;
        Utils.toastMessage('request sent');
      }).onError((error, stacktrace) {
        Utils.toastMessage('Unable to send request $error');
      });
    }
  }

  // Accept a friend request
  Future<void> acceptFriendRequest(String receiverUID, String senderUID, UserModel receiverData, UserModel senderData ) async {
    // Add to friends list
    await _firestore
        .collection('FriendSystem')
        .doc(receiverUID)
        .collection('friends')
        .doc(senderUID)
        .set({
      'friendUID': senderUID,
      'timestamp': FieldValue.serverTimestamp(),
      'data': senderData.toMap()
    });

    // Add receiver to sender's friend list
    await _firestore
        .collection('FriendSystem')
        .doc(senderUID)
        .collection('friends')
        .doc(receiverUID)
        .set({
      'friendUID': receiverUID,
      'timestamp': FieldValue.serverTimestamp(),
      'data': receiverData.toMap()
      
    });

    // Remove from request list
    await _firestore
        .collection('FriendSystem')
        .doc(receiverUID)
        .collection('requests')
        .doc(senderUID)
        .delete();
  }

  // Decline a friend request
  Future<void> declineFriendRequest(
      String receiverUID, String senderUID) async {
    await _firestore
        .collection('FriendSystem')
        .doc(receiverUID)
        .collection('requests')
        .doc(senderUID)
        .delete()
        .then((value) {
      requestsent.value = false;
      Utils.toastMessage('request withdrawn');
    });
  }

  // Remove a friend
  Future<void> removeFriend(String userUID, String friendUID) async {
    // Remove from user's friends list
    await _firestore
        .collection('FriendSystem')
        .doc(userUID)
        .collection('friends')
        .doc(friendUID)
        .delete();

    // Remove from friend's friends list
    await _firestore
        .collection('FriendSystem')
        .doc(friendUID)
        .collection('friends')
        .doc(userUID)
        .delete();
  }
}
