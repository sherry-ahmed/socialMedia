import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/baseModel/baseController.dart';
import 'package:socialmedia/view/dashboard/dashboard.dart';
import 'package:socialmedia/utils/utils.dart';
import 'package:socialmedia/services/sessionController.dart';

class Logincontroller extends GetxController {
  bool _loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final UserController userController = Get.put(UserController());
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    update();
  }

  void login(String email, String password) {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Sessioncontroller.userid = value.user!.uid.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('authToken', value.user!.uid);
        await userController.fetchUserData(value.user!.uid);

        Utils.toastMessage('Login Successfull');
        setLoading(false);
        Get.offAll(() => Dashboard());
      }).onError((error, StackTrace) {
        setLoading(false);

        Utils.toastMessage(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.toastMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.toastMessage('The account already exists for that email.');
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
