import 'package:socialmedia/baseComponents/imports.dart';

class DeleteAccount {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Delete the user from both Firebase Auth and Realtime Database
  Future<void> deleteUserAccount() async {
    try {
      // Get the currently authenticated user
      User? user = _auth.currentUser;

      if (user != null) {
        String uid = Sessioncontroller.userid.toString();

        // Step 1: Delete user's data from Realtime Database
        await _ref.child("Users").child(uid).remove().then((value) {
          Utils.toastMessage('data deleted successfully.');
        }).onError((error, stackTrace) {
          Utils.toastMessage("Error deleting data: $error");
        });

        await user.delete();

        Utils.toastMessage('auth deleted successfully.');
        Get.offAll(() => LoginScreen());
      } else {
        Utils.toastMessage("User not found.");
      }
    } catch (e) {
      Utils.toastMessage("Error deleting account: $e");
    }
  }
}
