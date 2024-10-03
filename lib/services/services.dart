import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Services {

  // Function to pick an image from either the gallery or camera
  static Future<String?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      // Pick an image from the specified source
      final XFile? pickedFile = await picker.pickImage(source: source, imageQuality: 100);

      if (pickedFile != null) {
        // Return the absolute path of the picked image
        return pickedFile.path;
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }


static Future<String?> uploadProfileImage(String imagePath, String userUid) async {
  try {
    // Create a reference to the Firebase Storage location
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(userUid)
        .child('profile');

    // Upload the image file
    UploadTask uploadTask = storageRef.putFile(File(imagePath).absolute);

    // Wait for the upload to complete
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get the download URL of the uploaded file
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    log("Image uploaded successfully. Download URL: $downloadUrl");

    // Return the download URL
    return downloadUrl;
  } catch (e) {
    print("Error uploading image: $e");
    return null;
  }
}



}
