import 'package:socialmedia/baseComponents/imports.dart';

class Signupcontroller extends GetxController {
  bool _loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  final UserController userController = Get.put(UserController());

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    update();
  }

  void signup(String username, String email, String password) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Utils.toastMessage('user created');
        Sessioncontroller.userid = value.user!.uid.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('authToken', value.user!.uid);
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'username': username,
          'profile': '',
          'isOnline': 'false'
        }).then((value) async{
          Utils.toastMessage('User Added');
          setLoading(false);
          await userController.fetchUserData(auth.currentUser!.uid);
          
          Get.offAll(() => Dashboard());
        }).onError((error, StackTrace) {
          setLoading(false);

          Utils.toastMessage(error.toString());
        });
      }).onError((error, StackTrace) {
        setLoading(false);

        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
