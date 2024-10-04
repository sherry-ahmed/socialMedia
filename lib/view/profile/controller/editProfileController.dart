import 'dart:io';
import 'package:socialmedia/baseComponents/imports.dart';

class Editprofilecontroller extends GetxController {
  File? imageFile;
  final UserController userController = Get.find();

  Future<void> pickImage(ImageSource source) async {
    final String? imagePath = await Services.pickImage(source);
    if (imagePath != null) {
      imageFile = File(imagePath);
      final String? newUrl = await Services.uploadProfileImage(
          imagePath, Sessioncontroller.userid.toString());
      if (newUrl != null) {
        UserModel updatedUser = userController.currentUser.value.copyWith(
          profile: newUrl,
        );
        await userController.updateUserData(updatedUser);
      }
      update();
    }
  }
}
