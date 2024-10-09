import 'package:socialmedia/baseComponents/imports.dart';

class Homecontroller extends GetxController{
  bool showsearchbar = false;
   searchbar(value){
    showsearchbar = value;
    update();
  }
  rebuild(){
    update();
  }

}