import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialmedia/res/color.dart';

class Utils {
  static void fieldfocus(BuildContext context, FocusNode currentfocus, FocusNode nextfocus){
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }
  static void toastMessage(String message){
    Fluttertoast.showToast(msg: message, backgroundColor: AppColors.primaryColor, textColor: Colors.white, gravity: ToastGravity.TOP);
  }
}