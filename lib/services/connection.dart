// import 'package:socialmedia/baseComponents/imports.dart';
// import 'package:socialmedia/baseModel/requestedUserController.dart';

// class Connection {
//   static final requestedUserController = Get.find<Requestedusercontroller>();
//   static final currentUserController = Get.find<UserController>();
//   static void sendrequest() {
//     try {
//       List<String> requestlist =
//           requestedUserController.requestedUser.value.requests!.toList();
//       requestlist.add(Sessioncontroller.userid.toString());
//       UserModel updatedUser =
//           requestedUserController.requestedUser.value.copyWith(requests: requestlist);
//       requestedUserController.updateRequestedUserData(
//           updatedUser, requestedUserController.requestedUser.value.uid.toString());

//       Utils.toastMessage('request sent');
//     } catch (e) {
//       Utils.toastMessage('Unable to send request ${e}');
//     }
//   }

//   static void withdrawRequest() {
//     try {
//       List<String> requestlist =
//           requestedUserController.requestedUser.value.requests!.toList();
//       List<String> friendslist =
//           requestedUserController.requestedUser.value.friends!.toList();
//       requestlist.remove(Sessioncontroller.userid.toString());
//       friendslist.remove(Sessioncontroller.userid.toString());
//       UserModel updatedUser = requestedUserController.requestedUser.value
//           .copyWith(requests: requestlist, friends: friendslist);
//       requestedUserController.updateRequestedUserData(
//           updatedUser, requestedUserController.requestedUser.value.uid.toString());
//       Utils.toastMessage('request withdrawn');
//     } catch (e) {
//       Utils.toastMessage('Unable to withdraw request ${e}');
//     }
//   }

//   static void acceptRequest(String uid) {
//     try {
      
//       List<String> requestlist =
//           currentUserController.currentUser.value.requests!.toList();
//       requestlist.remove(uid);
     
//       List<String> friendslist =
//           currentUserController.currentUser.value.friends!.toList();
//       friendslist.add(uid.toString());
//        requestedUserController.fetchAndUpdateFriends(uid, Sessioncontroller.userid.toString());
      
     
//       UserModel updatedCurrentUser =
//           currentUserController.currentUser.value.copyWith(friends: friendslist, requests: requestlist);
//       currentUserController.updateUserData(
//           updatedCurrentUser, Sessioncontroller.userid.toString());

//       Utils.toastMessage('request accepted');
//     } catch (e) {
//       Utils.toastMessage('Unable to accept request $e');
//     }
//   }
//   static void rejectRequest(String uid) {
//     try {
//       List<String> requestlist =
//           currentUserController.currentUser.value.requests!.toList();
//       requestlist.remove(uid);
     
//       UserModel updatedCurrentUser =
//           currentUserController.currentUser.value.copyWith(requests: requestlist);
//       currentUserController.updateUserData(
//           updatedCurrentUser, currentUserController.currentUser.value.uid.toString());

//       Utils.toastMessage('request rejected');
//     } catch (e) {
//       Utils.toastMessage('Unable to reject request $e');
//     }
//   }
// }
