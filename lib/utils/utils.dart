import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../baseComponents/imports.dart';

class Utils {
  static void fieldfocus(BuildContext context, FocusNode currentfocus, FocusNode nextfocus){
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }
  static void toastMessage(String message){
    Fluttertoast.showToast(msg: message, backgroundColor: AppColors.primaryColor, textColor: Colors.white, gravity: ToastGravity.TOP);
  }
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      mainButton: TextButton(
        onPressed: () {
          Get.back(); // Dismiss the snackbar
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}