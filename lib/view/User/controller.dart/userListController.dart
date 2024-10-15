import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/home/controller/homeController.dart';


class Userlistcontroller extends GetxController{
  final  homeController = Get.find<Homecontroller>();
  List<String> friends = [];
  
  

bool showsearchbar = false;
   searchbar(value){
    showsearchbar = value;
    update();
  }
  rebuild(){
    update();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homeController.listenToFriends(Sessioncontroller.userid.toString());
    for(int i = 0 ; i< homeController.friendList.length; i++){
      UserModel user = homeController.friendList[i];
      friends.add(user.uid);
    }
    log(friends.toString());
    update();
    
  }
  
  

}