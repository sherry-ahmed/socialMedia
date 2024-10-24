import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/mapScreen/controller/mapviewController.dart';
import 'package:socialmedia/view/mapScreen/viewModels/checkedInLocationModel.dart';

class Checkincontroller extends GetxController {
  final mapController = Get.find<MapScreenController>();
  final TextEditingController storylineController = TextEditingController();
  final TextEditingController placenameController = TextEditingController();
  
  RxString imageUrl=''.obs; 
  RxString address = ''.obs; 
  RxBool isLoading = false.obs;
  RxString imagePath = ''.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addCheckedInLocation(CheckedInLocation location) async {
    final timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    try {
      await firestore
          .collection('checkedinLocation')
          .doc(Sessioncontroller.userid)
          .collection('visits')
          .doc(timestamp)
          .set(
            location.toMap(),

            SetOptions(
                merge:
                    true), // This will merge the data, rather than overwrite the entire document.
          );
      log('Check-in location added successfully.');
    } catch (e) {
      log('Error adding check-in location: $e');
    }
  }
    Future<void> pickImage(ImageSource source, ) async {
     imagePath.value = await Services.pickImage(source);
  }
  Future<void> saveData ()async{
    
    isLoading.value = true;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    Placemark? place = await Services.getAddressFromLatLng(mapController.currentPosition.value);
    address.value = '${placenameController.text.trim()}, ${place!.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
    log(address.value);
    if(imagePath.value!=''){
      File imageFile = File(imagePath.value);
      Uint8List imageBytes = await imageFile.readAsBytes();
      Uint8List? compressedImageBytes =
          await Services.compressImage(imageBytes);
      imageUrl.value = (await Services.uploadCheckedinImage(compressedImageBytes!, Sessioncontroller.userid.toString(), timestamp))!;
    }
    CheckedInLocation location = CheckedInLocation(
              userId: Sessioncontroller.userid.toString(),
              storyline: storylineController.text.trim(),
              imageUrl: imageUrl.value ,
              address: address.value,
              placeName: placenameController.text.trim(),
              latitude: mapController.currentPosition.value.latitude,
              longitude: mapController.currentPosition.value.longitude,
              eventId: timestamp.toString(),
            );
            final messagesRef = firestore
        .collection('checkedInLocations')
        .doc(Sessioncontroller.userid)
        .collection('visits')
        .doc(timestamp.toString());

    try {
      // First, upload the message
      await messagesRef.set(location.toMap());
      isLoading.value = false;
      storylineController.clear();
      imagePath.value='';
      placenameController.clear();
      Get.back();

     
    } catch (error) {
      log('Error uploading location: $error');
      isLoading.value= false;
    }


  }
}
