import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/mapScreen/viewModels/checkedInLocationModel.dart';

class GlobalCheckedinviewcontroller extends GetxController {
  RxBool isLoading = false.obs;
  StreamSubscription<QuerySnapshot>? checkedinSubscription;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<CheckedInLocation> checkeInLocationlist = <CheckedInLocation>[].obs;
  void listentoCheckIns(String userid) {
    log('function calls');
    isLoading.value = true;

    checkedinSubscription = firestore
        .collection('checkedInLocations')
        .doc(userid)
        .collection('visits')
        .orderBy('eventId')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        checkeInLocationlist.clear();
        for (var doc in snapshot.docs) {
          CheckedInLocation checkedInLocation =
              CheckedInLocation.fromDocument(doc);
          checkeInLocationlist.add(checkedInLocation);
        }
        isLoading.value = false;
      } else {
        // No messages found
        log('no locations added');
        isLoading.value = false;
      }
    });
  }
  Future<void> deleteCheckInLocation(String userId, String eventId) async {
  try {
    // Get the reference to the user's visits collection
     await firestore
        .collection('checkedInLocations')
        .doc(userId)
        .collection('visits')
        .doc(eventId)
        .delete();
        log('deleted from store');
       final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('CheckedInLocations')
        .child(userId)
        .child(eventId);
        await storageRef.delete();
        log('deleted from storage');



    // if (querySnapshot.docs.isNotEmpty) {
    //   for (var doc in querySnapshot.docs) {
    //     // Delete the document
    //     await firestore
    //         .collection('checkedInLocations')
    //         .doc(userId)
    //         .collection('visits')
    //         .doc(doc.id)
    //         .delete();

    //     log('Check-in location deleted for eventId: $eventId');
    //   }
    // } else {
    //   log('No check-in location found for eventId: $eventId');
    // }
  } catch (e) {
    log('Error deleting check-in location: $e');
  }
}
}
