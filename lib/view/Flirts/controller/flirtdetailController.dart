import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Flirtdetailcontroller extends GetxController {
  RxBool isFriend = false.obs;
  RxBool isrequest = false.obs;
  final  friendController = Get.find<FriendController>();

  close() {
    isFriend.value = false;
    isrequest.value = false;
    log('friend set to false');
  }

  final controller = Get.find<Flirtcontroller>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Color dominantColor = Colors.red;
  Future<void> checkfriend(String senderUID, String receiverUID) async {
    DocumentSnapshot receiverSnapshot = await firestore
        .collection('FriendSystem')
        .doc(senderUID)
        .collection('friends')
        .doc(receiverUID)
        .get();
    if (receiverSnapshot.exists) {
      isFriend.value = true;

      // Exit the function if already friends
    } else {
      isFriend.value = false;
    }
  }
  Future<void> checkrequest(String senderUID, String receiverUID) async {
    DocumentSnapshot receiverSnapshot = await firestore
        .collection('FriendSystem')
        .doc(senderUID)
        .collection('requests')
        .doc(receiverUID)
        .get();
    if (receiverSnapshot.exists) {
      isrequest.value = true;

      // Exit the function if already friends
    } else {
      isrequest.value = false;
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