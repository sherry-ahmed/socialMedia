import 'package:socialmedia/baseComponents/imports.dart';

class Requestedusercontroller extends GetxController {
    var requestedUser = UserModel(
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
      friends: [],
      requests: [],
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

  Future<void> fetchRequestedUserData(String uid) async {
    try {
      DataSnapshot snapshot = await _ref.child("Users").child(uid).get();
      if (snapshot.exists) {
        Map<Object?, Object?> firebaseData = snapshot.value as Map<Object?, Object?>;
        
        Map<String, dynamic> userData = firebaseData.map((key, value) {
          return MapEntry(key.toString(), value);
        });

        requestedUser.value = UserModel.fromMap(userData);
        log(requestedUser.value.uid.toString());
      } else {
        log("Requested User not found");
      }
    } catch (e) {
      log("Error fetching requested user data: $e");
    }
  }
  

  Future<void> updateRequestedUserData(UserModel updatedUser, String uid) async {
    try {
      await _ref.child("Users").child(uid).update(updatedUser.toMap());
      requestedUser.value = updatedUser; 
      update();
      log('requested user data updated');
    } catch (e) {
      log('error updated requested user data${e}');
    }
  }
}
