import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:socialmedia/services/imports.dart';


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
      log('Error picking image: $e');
    }
    return null;
  }


static Future<String?> uploadProfileImage(String imagePath, String userUid) async {
  try {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(userUid)
        .child('profile');

    UploadTask uploadTask = storageRef.putFile(File(imagePath).absolute);

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    log("Image uploaded successfully. Download URL: $downloadUrl");

    // Return the download URL
    return downloadUrl;
  } catch (e) {
    log("Error uploading image: $e");
    return null;
  }
}
static String getChatroomId(String senderUID, String receiverUID) {
    if (senderUID.compareTo(receiverUID) < 0) {
      return "$senderUID\_$receiverUID"; // Alphabetical order
    } else {
      return "$receiverUID\_$senderUID";
    }
  }
  static void launchURL(String? url) async {
    if (url != null) {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // log('Could not launch $url');
        Utils.toastMessage("Invalid Profile Link");
      }
    } else {
      log('URL is null');
    }
  }

static Future<String?> sendImage(String imagePath, String chatroomId) async {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  try {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('chatrooms')
        .child(chatroomId)
        .child(timestamp.toString());

    UploadTask uploadTask = storageRef.putFile(File(imagePath).absolute);

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    log("Image uploaded successfully. Download URL: $downloadUrl");

    // Return the download URL
    return downloadUrl;
  } catch (e) {
    log("Error uploading image: $e");
    return null;
  }
}

}
