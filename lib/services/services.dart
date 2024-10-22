import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:http/http.dart' as http;

class Services {

  // Function to pick an image from either the gallery or camera
  static Future<String> pickImage(ImageSource source) async {
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
    return '';
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

static Future<String?> uploadCheckedinImage(String imagePath, String userUid, int timestamp) async {
  try {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('CheckedInLocations')
        .child(userUid)
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

static Future<String?> sendImage(Uint8List imageBytes, String chatroomId, int timestamp) async {
  //final timestamp = DateTime.now().millisecondsSinceEpoch;
  try {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('chatrooms')
        .child(chatroomId)
        .child(timestamp.toString());

    UploadTask uploadTask = storageRef.putData(imageBytes);

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
// Compress image in memory (returns Uint8List)
  static Future<Uint8List?> compressImage(Uint8List imageBytes) async {
  final Uint8List? compressedImage = await FlutterImageCompress.compressWithList(
    imageBytes,
    minWidth: 800,
    minHeight: 800,
    quality: 70, // Adjust the quality
  );
  
  return compressedImage;
}
static Future<String?> uploadAudioToCloudStorage(File filePath, String chatroomId, int timeStamp) async {
  try {
    

       if (!filePath.existsSync()) {
      log('Error: Audio file does not exist at path: $filePath');
      
      return null; // Return null if the file does not exist
    }
    // Create a reference to the Firebase Storage
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('chatrooms')
        .child(chatroomId)
        .child("${timeStamp.toString()}.mp3");// Using the file name from the path

    // Upload the audio file
   
    await storageRef.putFile(filePath, SettableMetadata(contentType: 'audio/wav'));

    // Get the download URL after upload
    String downloadUrl = await storageRef.getDownloadURL();
    log('Audio uploaded successfully. Download URL: $downloadUrl');
    return downloadUrl; // Return the download URL if needed
  } catch (e) {
    log('Error uploading audio: $e');
    return null; // Return null in case of an error
  }
}


// Then pass the local file path to VoiceMessageView
static Future<Placemark?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return place;
     
    } catch (e) {
      return null;
      
      print(e);
    }
  }


}
