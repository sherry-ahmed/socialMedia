// import 'package:socialmedia/services/imports.dart';

// class SplashController extends GetxController {
//   final UserController userController = Get.put(UserController());
  
  
//   @override
//   void onReady() {
//     super.onReady();
//     _checkCurrentUser();
//   }

//   Future<void> _checkCurrentUser() async {
//     if(await Services.checkInternetConnectivity()==false){
//       Utils.showSnackbar('No Internet', 'Check you network connection');
//     }else{
//       await Future.delayed(
//         const Duration(seconds: 3)); // Duration for splash screen

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? authToken = prefs.getString('authToken');

//     if (authToken != null) {
//       // Check if the user is still authenticated with Firebase
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null && user.uid == authToken) {
//         Sessioncontroller.userid = user.uid.toString();
//         await userController.fetchUserData(user.uid);
        
        

//         Get.offAll(() =>  Dashboard());
//       } else {
//         Get.to(() => LoginScreen());
//       }
//     } else {
//       Get.to(() => LoginScreen());
//     }

//     }
    
//   }
// }
import 'package:socialmedia/services/imports.dart';

class SplashController extends GetxController {
  final UserController userController = Get.put(UserController());

  @override
  void onReady() {
    super.onReady();
    _checkCurrentUser();
  }

  // Method to check for internet and proceed accordingly
  // Future<void> _checkInternetAndProceed() async {
  //   // Check if there is internet connectivity
  //   bool hasInternet = await Services.checkInternetConnectivity();
    
  //   // Show snackbar if no internet, and keep checking
  //   while (!hasInternet) {
  //     Utils.showSnackbar('No Internet', 'Check your network connection');
      
  //     // Wait for a while before rechecking the connection
  //     await Future.delayed(const Duration(seconds: 5));
      
  //     // Recheck connectivity
  //     hasInternet = await Services.checkInternetConnectivity();
  //   }

  //   // Once the internet is available, proceed with user check
  //   await _checkCurrentUser();
  // }

  // Method to check the current user and proceed accordingly
  Future<void> _checkCurrentUser() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate splash delay

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');

    if (authToken != null) {
      // Check if the user is still authenticated with Firebase
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.uid == authToken) {
        Sessioncontroller.userid = user.uid.toString();
        await userController.fetchUserData(user.uid);

        // Navigate to Dashboard if authenticated
        Get.offAll(() => Dashboard());
      } else {
        // Navigate to Login if not authenticated
        Get.to(() => LoginScreen());
      }
    } else {
      // Navigate to Login if no authToken
      Get.to(() => LoginScreen());
    }
  }
}
