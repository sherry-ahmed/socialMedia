import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class Flirtdetailcontroller extends GetxController {
  RxBool isFriend = false.obs;

  final controller = Get.find<Flirtcontroller>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Color dominantColor = Colors.red;
  Future<void> sendFriendRequest(String senderUID, String receiverUID) async {
    DocumentSnapshot receiverSnapshot = await firestore
        .collection('FriendSystem')
        .doc(senderUID)
        .collection('friends')
        .doc(receiverUID)
        .get();
    if (receiverSnapshot.exists) {
      isFriend.value = true;

      // Exit the function if already friends
    }
  }

  void launchURL(String? url) async {
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
}








   //  Future<void> extractColors(String profile) async {
  //   final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
  //     NetworkImage(profile),
  //      // Replace with your image URL
  //   );
  //   dominantColor = paletteGenerator.dominantColor!.color;


  // }