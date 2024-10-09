import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Friendrequests extends StatelessWidget {
   Friendrequests({super.key});
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Friend Requests',
          onBackPressed: () {
            Get.back();
          },
        ),
        body: InkWell(
          onTap: () {},
          child: Card(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userController.currentUser.value.profile),
                              // snapshot.child('profile').value.toString().isEmpty
                              //     ? AssetImage(Assets.images.user.path)
                              //         as ImageProvider
                              //     : NetworkImage(
                              //         snapshot.child('profile').value.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SB.w(20),
                    // User Info
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userController.currentUser.value.username,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${userController.currentUser.value.country}, ${userController.currentUser.value.state}, ${userController.currentUser.value.city},",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12),
                        ),
                      
                
                        // Text(
                        //   snapshot.child('username').value.toString(),
                        //   style: Theme.of(context).textTheme.titleMedium,
                        // ),
                        // Text(
                        //   snapshot.child('email').value.toString(),
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .titleMedium!
                        //       .copyWith(fontSize: 12),
                        // ),
                      ],
                    ),
                    const Spacer(),
                    // SizedBox(
                    //   height: 30,
                    //   width: 30,
                    //   child: StreamBuilder<int>(
                    //     stream: controller.getUnreadMessageCount(
                    //         Services.getChatroomId(
                    //             Sessioncontroller.userid
                    //                 .toString(),
                    //             snapshot
                    //                 .child('uid')
                    //                 .value
                    //                 .toString()),
                    //         Sessioncontroller.userid.toString()),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData &&
                    //           snapshot.data! > 0) {
                    //         return Container(
                    //           height: 7,
                    //           width: 7,
                    //           decoration: const BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: Colors.black),
                    //           child: Center(
                    //             child: Text(
                    //               "${snapshot.data!}",
                    //               style: const TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 16),
                    //             ),
                    //           ),
                    //         );
                    //       } else {
                    //         return Container(); // No unread messages
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
