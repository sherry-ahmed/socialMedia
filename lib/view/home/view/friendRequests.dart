import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Friendrequests extends StatelessWidget {
  final FriendController friendController = Get.put(FriendController());
  final userController = Get.find<UserController>();
  final String currentUserUID;

  Friendrequests({super.key, required this.currentUserUID}) {
    friendController.listenToFriendRequests(currentUserUID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Friend Requests',
        onBackPressed: () {
          Get.back();
        },
      ),
      body: Obx(() {
        if (friendController.requestList.isEmpty) {
          // Show 'No Request' message if no data
          return const Center(
            child: Text('No Request',
                style: TextStyle(color: Colors.white54, fontSize: 30)),
          );
        } else {
          // Show data if it exists
          return ListView.builder(
            itemCount: friendController.requestList.length,
            itemBuilder: (context, index) {
              UserModel user = friendController.requestList[index];

              return SizedBox(
                height: 100,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileImage(
                            profile: user.profile, height: 50, width: 50,),

                        SB.w(20),
                        // User Info
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "${user.personalityType}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                friendController.declineFriendRequest(
                                    Sessioncontroller.userid.toString(),
                                    user.uid);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                elevation: 10,
                                shadowColor: Colors.red,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            SB.w(context.width * 0.05),
                            GestureDetector(
                              onTap: () {
                                friendController.acceptFriendRequest(
                                    Sessioncontroller.userid.toString(),
                                    user.uid,
                                    userController.currentUser.value,
                                    user);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                elevation: 10,
                                shadowColor: Colors.black,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
