import 'package:socialmedia/services/imports.dart';

class Forgotcontroller extends GetxController {
  bool _loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    update();
  }

  void forgotPassword(String email) {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) async {
        setLoading(false);
        Get.to(() => LoginScreen());
        Utils.toastMessage('Check Your Email\nPassword Reset link sent');
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
