import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/home/controller/homeController.dart';


class Userlistcontroller extends GetxController{
  List<String> friends = [];
  
   

bool showsearchbar = false;
   searchbar(value){
    showsearchbar = value;
    update();
  }
  rebuild(){
    update();
  }

}