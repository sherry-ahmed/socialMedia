import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/requestedUserController.dart';

class Connection {
  static final requestedUser = Get.find<Requestedusercontroller>();
  static void sendrequest(){
    try{
      List<String> requestlist = requestedUser.requestedUser.value.requests!.toList();
    requestlist.add(Sessioncontroller.userid.toString());
    UserModel updatedUser = requestedUser.requestedUser.value.copyWith(requests: requestlist);
    requestedUser.updateRequestedUserData(updatedUser, requestedUser.requestedUser.value.uid.toString());
    
    Utils.toastMessage('request sent');

    }catch(e){
      Utils.toastMessage('Unable to send request ${e}');

    }
    


  }
  static void withdrawRequest(){
    try{
      List<String> requestlist = requestedUser.requestedUser.value.requests!.toList();
    List<String> friendslist = requestedUser.requestedUser.value.friends!.toList();
    requestlist.remove(Sessioncontroller.userid.toString());
    friendslist.remove(Sessioncontroller.userid.toString());
     UserModel updatedUser = requestedUser.requestedUser.value.copyWith(requests: requestlist,friends: friendslist);
    requestedUser.updateRequestedUserData(updatedUser, requestedUser.requestedUser.value.uid.toString());
    Utils.toastMessage('request withdrawn');

    }catch(e){
      Utils.toastMessage('Unable to withdraw request ${e}');

    }
    

    
    


  }
}