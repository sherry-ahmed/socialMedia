import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Editprofilecontroller extends GetxController {
  File? imageFile;
  final UserController userController = Get.find();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final facebookController = TextEditingController();
  final instaController = TextEditingController();
  final twitterController = TextEditingController();
  RxString countryValue = 'Country'.obs;
  RxString stateValue = 'State'.obs;
  RxString cityValue = 'City'.obs;
  RxString gender = ''.obs;
  RxString sexualOrientation = ''.obs;
  RxString relationshipType = ''.obs;
  RxString personalityType = ''.obs;
  RxList<String> Interests = [''].obs;
  List<int>? dob = [];
  Rxn<DateTime> selectedTime = Rxn<DateTime>();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
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
        : bioController.text = userController.currentUser.value.bio.toString();
    userController.currentUser.value.dateOfBirth!.isEmpty
        ? null
        : selectedTime.value = convertListToDateTime(
            userController.currentUser.value.dateOfBirth!);

    userController.currentUser.value.gender == null
        ? gender.value = ''
        : gender.value = userController.currentUser.value.gender.toString();
    userController.currentUser.value.personalityType == null
        ? personalityType.value = ''
        : personalityType.value =
            userController.currentUser.value.personalityType.toString();
    userController.currentUser.value.relationshipType == null
        ? relationshipType.value = ''
        : relationshipType.value =
            userController.currentUser.value.relationshipType.toString();
    userController.currentUser.value.sexualOrientation == null
        ? sexualOrientation.value = ''
        : sexualOrientation.value =
            userController.currentUser.value.sexualOrientation.toString();
    userController.currentUser.value.hobbies == null
        ? Interests.value = []
        : Interests.value = userController.currentUser.value.hobbies!.toList();
    userController.currentUser.value.fbLink == null
        ? facebookController.clear()
        : facebookController.text =
            userController.currentUser.value.fbLink.toString();
    userController.currentUser.value.instaLink == null
        ? instaController.clear()
        : instaController.text =
            userController.currentUser.value.instaLink.toString();
    userController.currentUser.value.instaLink == null
        ? twitterController.clear()
        : twitterController.text =
            userController.currentUser.value.instaLink.toString();
    userController.currentUser.value.country == null
        ? countryValue.value = 'Country'
        : countryValue.value =
            userController.currentUser.value.country.toString();
    userController.currentUser.value.state == null
        ? stateValue.value = 'State'
        : stateValue.value = userController.currentUser.value.state.toString();
    userController.currentUser.value.city == null
        ? cityValue.value = 'City'
        : cityValue.value = userController.currentUser.value.city.toString();
  }

  Future<void> updateData() async {
    if (phoneController.text.isEmpty &&
        bioController.text.isEmpty &&
        gender.value == '' &&
        sexualOrientation.value == '' &&
        personalityType.value == '' &&
        relationshipType.value == '' &&
        cityValue.value == 'City' &&
        stateValue.value == 'State' &&
        countryValue.value == 'Country') {
      Utils.toastMessage('Please check All fields');
    } else {
      UserModel updatedUser = userController.currentUser.value.copyWith(
        username: nameController.text,
        phone: phoneController.text.isEmpty ? '' : phoneController.text,
        bio: bioController.text.isEmpty ? '' : bioController.text,
        dateOfBirth: updateUserDateOfBirth(),
        gender: gender.value,
        sexualOrientation: sexualOrientation.value,
        relationshipType: relationshipType.value,
        personalityType: personalityType.value,
        country: countryValue.value,
        state: stateValue.value,
        city: cityValue.value,
        age: calculateAge(selectedTime.value),
      );

      await userController.updateUserData(
          updatedUser, Sessioncontroller.userid.toString());
      Get.back(); // Go b Go back after updating
    }
  }

  Future<void> updateSocials() async {
    UserModel updatedsocials = userController.currentUser.value.copyWith(
      fbLink: facebookController.text.isEmpty ? '' : facebookController.text,
      instaLink: instaController.text.isEmpty ? '' : instaController.text,
      tiktokLink: twitterController.text.isEmpty ? '' : twitterController.text,
    );

    await userController.updateUserData(
        updatedsocials, Sessioncontroller.userid.toString());
    Get.back(); // Go b Go back after updating
  }

  Future<void> updateInterests() async {
    UserModel updatedInterests =
        userController.currentUser.value.copyWith(hobbies: Interests);

    await userController.updateUserData(
        updatedInterests, Sessioncontroller.userid.toString());
    Get.back(); // Go b Go back after updating
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
        await userController.updateUserData(
            updatedUser, Sessioncontroller.userid.toString());
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

  void checkLink(
      {required String title, required TextEditingController controller}) {
    bool isValidUrl(String url, String platform) {
      final RegExp urlPattern = RegExp(
        r'^(https?:\/\/)?(www\.)?' + platform + r'\.com\/[a-zA-Z0-9(\.\?)?]',
        caseSensitive: false,
      );
      return urlPattern.hasMatch(url) ? true : false;
    }

    if (title == 'facebook') {
      var check = isValidUrl(controller.text, 'facebook');
      log(check.toString());
      if (check) {
        log(facebookController.text);
        facebookController.text = controller.text;

        Get.back();
      } else {
        controller.clear();
        Get.back();
        Utils.showSnackbar('Error', "Invalid Facebook link");
      }
    }
    if (title == 'insta') {
      var check = isValidUrl(controller.text, 'instagram');
      log(check.toString());
      if (check) {
        instaController.text = controller.text;
        Get.back();
      } else {
        controller.clear();
        Get.back();
        Utils.showSnackbar('Error', "Invalid Instagram link");
      }
    }
    if (title == 'twitter') {
      var check = isValidUrl(controller.text, 'twitter');
      log(check.toString());
      if (check) {
        twitterController.text = controller.text;
        Get.back();
      } else {
        controller.clear();
        Get.back();
        Utils.showSnackbar('Error', "Invalid twitter link");
      }
    }
  }

  DateTime convertListToDateTime(List<int> dobList) {
    return DateTime(dobList[0], dobList[1], dobList[2]);
  }

  List<int> updateUserDateOfBirth() {
    List<int> dob = [
      selectedTime.value!.year,
      selectedTime.value!.month,
      selectedTime.value!.day,
    ];
    return dob;

    // Create a new user model with updated dateOfBirth
  }

  int calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 0; // If the birthDate is null, return 0

    DateTime currentDate = DateTime.now();

    // Calculate the difference in years
    int age = currentDate.year - birthDate.year;

    // Adjust the age if the birthday hasn't occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
