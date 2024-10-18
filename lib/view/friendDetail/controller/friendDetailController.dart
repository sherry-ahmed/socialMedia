import 'package:socialmedia/services/imports.dart';

class Frienddetailcontroller extends GetxController{
  RxBool chatlock = false.obs;
  RxBool favourite = false.obs;

  togglechatlock(){
    chatlock.value = !chatlock.value;
  }
  togglefavourite(){
    favourite.value = !favourite.value;

  }

}