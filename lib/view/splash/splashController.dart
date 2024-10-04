import 'package:socialmedia/baseComponents/imports.dart';

class SplashController extends GetxController {
  final UserController userController = Get.put(UserController());
  @override
  void onReady() {
    super.onReady();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Duration for splash screen

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    if (authToken != null) {
      // Check if the user is still authenticated with Firebase
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.uid == authToken) {
        Sessioncontroller.userid = user.uid.toString();
        await userController.fetchUserData(user.uid);

        Get.offAll(() =>  Dashboard());
      } else {
        Get.to(() => LoginScreen());
      }
    } else {
      Get.to(() => LoginScreen());
    }
  }
}
