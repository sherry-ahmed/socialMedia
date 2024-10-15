import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';


class UserListScreen extends StatelessWidget {
  UserListScreen({super.key});

  final DatabaseReference userRef = FirebaseDatabase.instance.ref('Users');
  final searchController = TextEditingController();
  final friendController = Get.find<FriendController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<Userlistcontroller>(
          init: Userlistcontroller(),
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                AnimatedContainer(
                  curve: Curves.easeIn,
                  height: controller.showsearchbar ? 60 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: controller.showsearchbar
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Searchbar(searchController: searchController),
                        )
                      : const SizedBox(),
                ),
                !controller.showsearchbar
                    ? SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            SB.w(12),
                            Text(
                              'Add friends',
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.searchbar(true);
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                                const PopMenuitem(),
                              ],
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                SB.h(30),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: userRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      //UserModel user = friendController.friendList[index];
                      if (!snapshot.exists) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else {
                        if (Sessioncontroller.userid.toString() ==
                            snapshot.child('uid').value.toString()) {
                          return const SizedBox();
                        } 
                        else if (controller.friends
                            .contains(snapshot.child('uid').value.toString())) {
                          return SizedBox();
                        } 
                        else {
                          final username =
                              snapshot.child('username').value.toString();
                          if (searchController.text.isEmpty ||
                              username.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                            return SlideTransition(
                              position: animation.drive(
                                Tween<Offset>(
                                  begin: const Offset(1, 0), // Start from right
                                  end: Offset
                                      .zero, // Slide to its normal position
                                ).chain(
                                  CurveTween(curve: Curves.linear),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Get.to(() => Chatroom(
                                  //       receiverUID: snapshot.child('uid').value.toString(),
                                  //       profile: snapshot.child('profile').value.toString(),
                                  //       username: snapshot.child('username').value.toString(),
                                  //     ));
                                },
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        snapshot
                                                .child('profile')
                                                .value
                                                .toString()
                                                .isEmpty
                                            ? Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.black,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      Assets.images.user.path,
                                                    ) as ImageProvider,
                                                  ),
                                                ),
                                              )
                                            : profileImage(
                                                profile: snapshot
                                                    .child('profile')
                                                    .value
                                                    .toString(),
                                                height: 50,
                                                width: 50,
                                              ),
                                        SB.w(20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot
                                                  .child('username')
                                                  .value
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              snapshot
                                                  .child('email')
                                                  .value
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        // SizedBox(
                                        //   height: 30,
                                        //   width: 30,
                                        //   child: StreamBuilder<int>(
                                        //     stream: controller.getUnreadMessageCount(
                                        //       Services.getChatroomId(
                                        //         Sessioncontroller.userid.toString(),
                                        //         snapshot.child('uid').value.toString(),
                                        //       ),
                                        //       Sessioncontroller.userid.toString(),
                                        //     ),
                                        //     builder: (context, snapshot) {
                                        //       if (snapshot.hasData && snapshot.data! > 0) {
                                        //         return Container(
                                        //           height: 7,
                                        //           width: 7,
                                        //           decoration: const BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             color: Colors.black,
                                        //           ),
                                        //           child: Center(
                                        //             child: Text(
                                        //               "${snapshot.data!}",
                                        //               style: const TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 16,
                                        //               ),
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
                            );
                          } else {
                            return Container();
                          }
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
