import 'package:socialmedia/components/imports.dart';

class Userlistcontroller extends GetxController{

bool showsearchbar = false;
   searchbar(value){
    showsearchbar = value;
    update();
  }
  rebuild(){
    update();
  }
}