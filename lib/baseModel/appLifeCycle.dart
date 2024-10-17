import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/services/imports.dart';


class AppLifecycleController extends SuperController
    with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    updateOnlineStatus(true);
    updateTypingStatus(false);
  }

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  void updateOnlineStatus(bool onlineStatus) {
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
      updateOnlineStatus(false);
    } else if (state == AppLifecycleState.resumed) {
      updateOnlineStatus(true);
    }else if (state == AppLifecycleState.detached) {
      updateOnlineStatus(false);
    }else if (state == AppLifecycleState.hidden) {
      updateOnlineStatus(false);
    }else if (state == AppLifecycleState.inactive) {
      updateOnlineStatus(false);
    }
  }

  @override
  void onClose() {
    updateOnlineStatus(false);
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void onHidden() {
    updateOnlineStatus(false);
  }

  @override
  void onDetached() {
    updateOnlineStatus(false);
  }

  @override
  void onInactive() {
    updateOnlineStatus(false);
  }

  @override
  void onPaused() {
    updateOnlineStatus(false);
  }

  @override
  void onResumed() {
    updateOnlineStatus(true);
  }
}
