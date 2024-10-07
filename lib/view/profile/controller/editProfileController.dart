import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Editprofilecontroller extends GetxController {
  File? imageFile;
  final UserController userController = Get.find();
  final  nameController = TextEditingController();
  final  emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  RxString gender = ''.obs;
  RxString sexualOrientation = ''.obs;
  RxString relationshipType = ''.obs;
  RxString personalityType = ''.obs;
  RxList<String> Interests = [''].obs;
  final List<int>? dob=[];
  Rxn<DateTime> selectedTime = Rxn<DateTime>();
  final formKey = GlobalKey<FormState>();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setData();
  }

  void setData() {
    nameController.text = userController.currentUser.value.username;
    emailController.text = userController.currentUser.value.email;
    userController.currentUser.value.phone == null
        ? phoneController.clear()
        : phoneController.text =
            userController.currentUser.value.phone.toString();
     userController.currentUser.value.bio == null
        ? bioController.clear()
        : bioController.text =
            userController.currentUser.value.phone.toString();
      userController.currentUser.value.dateOfBirth ==null? selectedTime.value=DateTime.now(): dob?? userController.currentUser.value.dateOfBirth; 

      userController.currentUser.value.gender ==null? gender.value = '': gender.value = userController.currentUser.value.gender.toString();
      userController.currentUser.value.personalityType ==null? personalityType.value = '': personalityType.value = userController.currentUser.value.personalityType.toString();
      userController.currentUser.value.relationshipType ==null? relationshipType.value = '': relationshipType.value = userController.currentUser.value.relationshipType.toString();
      userController.currentUser.value.sexualOrientation ==null? sexualOrientation.value = '': sexualOrientation.value = userController.currentUser.value.sexualOrientation.toString();
      userController.currentUser.value.hobbies ==null? Interests.value = []: Interests.value = userController.currentUser.value.hobbies!.toList();
  }

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
  Future<void> selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo =
        DateTime(now.year - 18, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTime.value ?? eighteenYearsAgo,
      firstDate: DateTime(1900),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      lastDate: eighteenYearsAgo,
    );
    if (picked != null && picked != DateTime.now()) {
      selectedTime.value = picked;
    }
    formKey.currentState!.validate();
  }
}


// final Rxn<DateTime> selectedTime = Rxn<DateTime>();

// void updateUserDateOfBirth(UserModel userModel) {
//   if (selectedTime.value != null) {
//     List<int> dob = [
//       selectedTime.value!.year,
//       selectedTime.value!.month,
//       selectedTime.value!.day,
//     ];

//     // Create a new user model with updated dateOfBirth
//     UserModel updatedUser = userModel.copyWith(dateOfBirth: dob);

//     // Now you can call updateUserData(updatedUser) to update Firebase
//     // For example:
//     userController.updateUserData(updatedUser);
//   }
// }

