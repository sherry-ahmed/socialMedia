// import 'package:socialmedia/baseComponents/imports.dart';

// class Requestedusercontroller extends GetxController {
//     var requestedUser = UserModel(
//       uid: '',
//       email: '',
//       username: '',
//       profile: '',
//       isOnline: 'false',
//       phone: null,
//       bio: null,
//       country: null,
//       state: null,
//       city: null,
//       hobbies: [],
//       friends: [],
//       requests: [],
//       age: null,
//       instaLink: null,
//       fbLink: null,
//       tiktokLink: null,
//       gender: null,
//       personalityType: null,
//       relationshipType: null,
//       sexualOrientation: null,
//       dateOfBirth: []
//     ).obs; 
    

//   final DatabaseReference _ref = FirebaseDatabase.instance.ref();

//   Future<void> fetchRequestedUserData(String uid) async {
//     try {
//       DataSnapshot snapshot = await _ref.child("Users").child(uid).get();
//       if (snapshot.exists) {
//         Map<Object?, Object?> firebaseData = snapshot.value as Map<Object?, Object?>;
        
//         Map<String, dynamic> userData = firebaseData.map((key, value) {
//           return MapEntry(key.toString(), value);
//         });

//         requestedUser.value = UserModel.fromMap(userData);
//         log(requestedUser.value.uid.toString());
//       } else {
//         log("Requested User not found");
//       }
//     } catch (e) {
//       log("Error fetching requested user data: $e");
//     }
//   }
  

//   Future<void> updateRequestedUserData(UserModel updatedUser, String uid) async {
//     try {
//       await _ref.child("Users").child(uid).update(updatedUser.toMap());
//       requestedUser.value = updatedUser; 
//       update();
//       log('requested user data updated');
//     } catch (e) {
//       log('error updated requested user data${e}');
//     }
//   }


// Future<void> fetchAndUpdateFriends(String uid, String newFriendUid) async {
//   try {
//     // Step 1: Fetch the existing friends list
//     DataSnapshot snapshot = await _ref.child("Users").child(uid).child("friends").get();
    
//     List<String> friendsList = [];

//     // Check if the friends list exists and convert it to a List<String>
//     if (snapshot.exists) {
//       // Retrieve the existing friends
//       Map<Object?, Object?> firebaseData = snapshot.value as Map<Object?, Object?>;
//       friendsList = firebaseData.values.map((friend) => friend.toString()).toList();
//     }

//     // Step 2: Update the friends list with new entries
    
//       if (!friendsList.contains(newFriendUid)) {
//         friendsList.add(newFriendUid); // Add only if not already present
//       }
    

//     // Step 3: Save the updated friends list back to the database
//     await _ref.child("Users").child(uid).child("friends").set(friendsList);

//     log("Friends list updated successfully: $friendsList");
//   } catch (e) {
//     log("Error fetching and updating friends list: $e");
//   }
// }


// }
