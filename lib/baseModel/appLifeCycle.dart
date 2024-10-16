import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/services/sessionController.dart';

class AppLifecycleController extends SuperController with WidgetsBindingObserver {
  RxBool isOnline = false.obs; // Observable to track online status

  // Method to update the user's online status in Firestore
  void updateOnlineStatus(bool onlineStatus) {
    isOnline.value = onlineStatus; // Update the observable
    FirebaseFirestore.instance
        .collection('users')
        .doc(Sessioncontroller.userid)
        .update({
      'isOnline': onlineStatus.toString(),
      
    });
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    updateOnlineStatus(true); // Set user as online when the app starts
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      updateOnlineStatus(false); // Set user as offline when app is paused
    } else if (state == AppLifecycleState.resumed) {
      updateOnlineStatus(true); // Set user as online when app is resumed
    }
  }

  @override
  void onClose() {
    updateOnlineStatus(false); // Set user as offline when app is closed
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
  @override
  void onHidden() {
    // TODO: implement onHidden
    updateOnlineStatus(false);
  }
  
  @override
  void onDetached() {
    // TODO: implement onDetached
  }
  
  @override
  void onInactive() {
    // TODO: implement onInactive
  }
  
  @override
  void onPaused() {
    // TODO: implement onPaused
  }
  
  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
