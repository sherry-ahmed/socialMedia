import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/services/sessionController.dart';

class AppLifecycleController extends SuperController
    with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    updateOnlineStatus(true); // Set user as online when the app starts
    updateTypingStatus(false);
  }

  RxBool isOnline = false.obs; // Observable to track online status
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  // Method to update the user's online status in Firestore
  void updateOnlineStatus(bool onlineStatus) {
    isOnline.value = onlineStatus; // Update the observable
    usersRef.doc(Sessioncontroller.userid).update({
      'isOnline': onlineStatus,
    });
  }

  void updateTypingStatus(bool isTyping) {
    usersRef.doc(Sessioncontroller.userid).update({
      'isTyping': isTyping,
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<bool> getOnlineStatus(String uid) {
    return _firestore
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot['isOnline'] ?? false);
  }

  Stream<bool> getTypingStatus(String uid) {
    return _firestore
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot['isTyping'] ?? false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
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
    updateOnlineStatus(false);
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    updateOnlineStatus(false);
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    updateOnlineStatus(false);
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    updateOnlineStatus(true);
  }
}
