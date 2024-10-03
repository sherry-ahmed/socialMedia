import 'package:socialmedia/components/imports.dart';
// Import your model

class UserController extends GetxController {
  var currentUser = UserModel(
    uid: '',
    email: '',
    username: '',
    profile: '',
    isOnline: 'false',
  ).obs; // Observable for the current user

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  // Method to fetch the current user data by UID
Future<void> fetchUserData(String uid) async {
  try {
    DataSnapshot snapshot = await _ref.child("Users").child(uid).get();
    if (snapshot.exists) {
      // Convert the generic map to a Map<String, dynamic>
      Map<Object?, Object?> firebaseData = snapshot.value as Map<Object?, Object?>;
      
      // Create a properly typed Map<String, dynamic>
      Map<String, dynamic> userData = firebaseData.map((key, value) {
        return MapEntry(key.toString(), value);
      });

      // Set the data to the currentUser observable
      currentUser.value = UserModel.fromMap(userData);
    } else {
      print("User not found");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}

  // Method to update user data in Firebase
  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      await _ref.child("Users").child(updatedUser.uid).update(updatedUser.toMap());
      currentUser.value = updatedUser; // Update the local data as well
      update();
      Utils.toastMessage('Data Updated Successfully');
    } catch (e) {
      Utils.toastMessage("Error updating user data: $e");
    }
  }
}
