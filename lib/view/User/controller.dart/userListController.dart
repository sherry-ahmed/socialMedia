import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/friendController.dart';

class Userlistcontroller extends GetxController{
  final FriendController friendController = Get.put(FriendController());
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
    friendController.listenToFriends(Sessioncontroller.userid.toString());
    for(int i = 0 ; i< friendController.friendList.length; i++){
      UserModel user = friendController.friendList[i];
      friends.add(user.uid);
    }
    log(friends.toString());
    update();
    
  }
  
  

}