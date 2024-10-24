import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Services {
  static Future<String> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: source, imageQuality: 100);
      if (pickedFile != null) {
        return pickedFile.path;
      }
    } catch (e) {
      log('Error picking image: $e');
    }
    return '';
  }

  static Future<String?> uploadProfileImage(
      String imagePath, String userUid) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('Users')
          .child(userUid)
          .child('profile');
      UploadTask uploadTask = storageRef.putFile(File(imagePath).absolute);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  static Future<String?> uploadCheckedinImage(
      Uint8List imageBytes, String userUid, int timestamp) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('CheckedInLocations')
          .child(userUid)
          .child(timestamp.toString());
      UploadTask uploadTask = storageRef.putData(imageBytes);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  static String getChatroomId(String senderUID, String receiverUID) {
    if (senderUID.compareTo(receiverUID) < 0) {
      return "${senderUID}_$receiverUID";
    } else {
      return "${receiverUID}_$senderUID";
    }
  }

  static void launchURL(String? url) async {
    if (url != null) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        Utils.toastMessage("Invalid Profile Link");
      }
    } else {
      log('URL is null');
    }
  }

  static Future<String?> sendImage(
      Uint8List imageBytes, String chatroomId, int timestamp) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('chatrooms')
          .child(chatroomId)
          .child(timestamp.toString());
      UploadTask uploadTask = storageRef.putData(imageBytes);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  static Future<Uint8List?> compressImage(Uint8List imageBytes) async {
    final Uint8List compressedImage =
        await FlutterImageCompress.compressWithList(
      imageBytes,
      minWidth: 800,
      minHeight: 800,
      quality: 70,
    );
    return compressedImage;
  }

  static Future<String?> uploadAudioToCloudStorage(
      File filePath, String chatroomId, int timeStamp) async {
    try {
      if (!filePath.existsSync()) {
        log('Error: Audio file does not exist at path: $filePath');

        return null;
      }
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('chatrooms')
          .child(chatroomId)
          .child("${timeStamp.toString()}.mp3");

      await storageRef.putFile(
          filePath, SettableMetadata(contentType: 'audio/wav'));

      String downloadUrl = await storageRef.getDownloadURL();
      log('Audio uploaded successfully. Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading audio: $e');
      return null;
    }
  }

  static Future<Placemark?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return place;
    } catch (e) {
      return null;
    }
  }

  static void showFullScreenImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        body: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: InteractiveViewer(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: imagePath,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
//   static Future<bool> checkInternetConnectivity() async {
//   bool hasInternet = false;
//   final connectivityResult = await Connectivity().checkConnectivity();
//   if (connectivityResult == ConnectivityResult.none) {
//     return hasInternet;
//   }
//   // return await InternetConnectionChecker().hasConnection;
//   return Future.value(true);
// }
}
