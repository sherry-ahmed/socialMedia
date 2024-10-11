import 'package:socialmedia/baseComponents/imports.dart';

class UserController extends GetxController {
    var currentUser = UserModel(
      uid: '',
      email: '',
      username: '',
      profile: '',
      isOnline: 'false',
      phone: null,
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
    

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  Future<void> fetchUserData(String uid) async {
    try {
      DataSnapshot snapshot = await _ref.child("Users").child(uid).get();
      if (snapshot.exists) {
        Map<Object?, Object?> firebaseData = snapshot.value as Map<Object?, Object?>;
        
        Map<String, dynamic> userData = firebaseData.map((key, value) {
          return MapEntry(key.toString(), value);
        });

        currentUser.value = UserModel.fromMap(userData);
        log(currentUser.value.uid.toString());
      } else {
        log("User not found");
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }
  

  Future<void> updateUserData(UserModel updatedUser, String uid) async {
    try {
      await _ref.child("Users").child(uid).update(updatedUser.toMap());
      currentUser.value = updatedUser; 
      update();
      Utils.toastMessage('Data Updated Successfully');
    } catch (e) {
      Utils.toastMessage("Error updating user data: $e");
    }
  }
}
