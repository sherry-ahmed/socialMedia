import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Signupcontroller extends GetxController {
  bool _loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');
  final UserController userController = Get.put(UserController());

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    update();
  }

  void signup(String username, String email, String password, String phone) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Utils.toastMessage('user created');
        Sessioncontroller.userid = value.user!.uid.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('authToken', value.user!.uid);
        UserModel updatedUser = userController.currentUser.value.copyWith(
            uid: value.user!.uid.toString(),
            email: value.user!.email.toString(),
            username: username,
            phone: phone,
            profile: null,
            bio: null,
            country: null,
            state: null,
            city: null,
            hobbies: [],
            age: null,
            instaLink: null,
            fbLink: null,
            tiktokLink: null,
            gender: null,
            personalityType: null,
            relationshipType: null,
            sexualOrientation: null,
            isOnline: '',
            dateOfBirth: []);
        usersRef
            .doc(value.user!.uid.toString())
            .set(updatedUser.toMap())
            .then((value) async {
          Utils.toastMessage('User Added');
          setLoading(false);
          await userController.fetchUserData(auth.currentUser!.uid);
          Get.offAll(Dashboard());
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
