import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class UserController extends GetxController {
  var currentUser = UserModel(
    uid: '',
    email: '',
    username: '',
    profile: '',
    isOnline: false,
    phone: '',
    isTyping: false,
    bio: null,
    country: null,
    state: null,
    city: null,
    hobbies: [],
    age: null,
    instaLink: null,
    fbLink: null,
    tiktokLink: null,
    gender: null,
    personalityType: null,
    relationshipType: null,
    sexualOrientation: null,
    dateOfBirth: []
  ).obs;

  // Reference to Firestore collection
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('Users');

  // Fetch user data from Firestore by UID
  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await usersRef.doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

        // Map Firestore data to UserModel
        currentUser.value = UserModel.fromMap(userData);
        log(currentUser.value.uid.toString());
      } else {
        log("User not found");
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }

  // Update user data in Firestore
  Future<void> updateUserData(UserModel updatedUser, String uid) async {
    try {
      // Update Firestore document with new user data
      await usersRef.doc(uid).update(updatedUser.toMap());
      
      // Update the local user data in the controller
      currentUser.value = updatedUser;
      update();  // Notify listeners to update UI
      Utils.toastMessage('Data Updated Successfully');
    } catch (e) {
      Utils.toastMessage("Error updating user data: $e");
    }
  }

}
