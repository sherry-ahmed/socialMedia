import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/checkedInView/view/checkedinView.dart';


class Flirtdetailscreen extends StatelessWidget {
  Flirtdetailscreen({super.key, required this.data});
  final UserModel data;
  final Flirtdetailcontroller controller = Get.put(Flirtdetailcontroller());
  final userController = Get.find<UserController>();

  final FriendController friendController = Get.put(FriendController());
  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.isFriend.value=false;
          friendController.requestsent.value = false;
          controller.close();
          log('false');
          return;
        }
      },
      
      
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: data.username,
          onBackPressed: () => Get.back(),
          actions: const [
            Blockreport(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SB.h(context.height * 0.05),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                          clipBehavior: Clip.hardEdge,
                          height: context.height * 0.5,
                          width: context.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.red,
                                  spreadRadius: 6,
                                  offset: Offset(0, 8),
                                  blurRadius: 20,
                                )
                              ]),
                          child: Imagecomponent(
                              profile: data.profile,
                              height: double.infinity,
                              width: double.infinity)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Column(
                          children: [
                            data.fbLink != ''
                                ? GestureDetector(
                                    onTap: () {
                                      controller.launchURL(data.fbLink);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 6),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child: Image.asset(
                                            Assets.icons.facebookPng.path,
                                            height: 30,
                                            width: 30,
                                          )),
                                    ),
                                  )
                                : const SizedBox(),
                            data.instaLink != ''
                                ? GestureDetector(
                                    onTap: () {
                                      controller.launchURL(data.instaLink);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 6),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child: Image.asset(
                                            Assets.icons.instaColoured.path,
                                            height: 30,
                                            width: 30,
                                          )),
                                    ),
                                  )
                                : const SizedBox(),
                            data.tiktokLink != ''
                                ? GestureDetector(
                                    onTap: () {
                                      controller.launchURL(data.tiktokLink);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 6),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child: Image.asset(
                                            Assets.icons.twitterColoured.path,
                                            height: 30,
                                            width: 30,
                                          )),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SB.h(context.height * 0.02),
                Row(
                  children: [
                    Text(
                      data.username.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    data.age == null
                        ? const SizedBox()
                        : Text(
                            "  ${data.age.toString()}",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                  ],
                ),
                Text(
                  data.bio.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16, color: Colors.black),
                ),
                Wrap(
                  spacing: 8.0, // Add spacing between the items
                  runSpacing: 8.0, // Add spacing between rows
                  children: List.generate(
                    data.hobbies!.length,
                    (index) => IntrinsicWidth(
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12),
                            child: Center(
                              child: Text(
                                data.hobbies![index].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SB.h(context.height * 0.08),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: context.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => Checkedinview(userid: data.uid));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 10,
                  shadowColor: Colors.red,
                  child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.place,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                     if (controller.isFriend.isTrue) {
                    Utils.toastMessage('Your are Already Friends');
                  } else {
                    friendController.requestsent.value == true
                        ? friendController.declineFriendRequest(
                            data.uid, Sessioncontroller.userid.toString())
                        : friendController.sendFriendRequest(
                            Sessioncontroller.userid.toString(),
                            data.uid,
                            userController.currentUser.value);
                  }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    elevation: 10,
                    shadowColor: Colors.red,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: controller.isFriend.isTrue || controller.isrequest.isTrue ||
                              friendController.requestsent.isTrue
                          ? Colors.black
                          : Colors.white,
                      child: Icon(
                        Icons.person_add,
                        color: controller.isFriend.isTrue ||controller.isrequest.isTrue ||
                                friendController.requestsent.isTrue
                            ? Colors.white
                            : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.isFriend.value == true) {
                    Get.to(() => Chatroom(
                      user: data,
                     
                        ));
                  } else {
                    Utils.toastMessage('Account is Private');
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  elevation: 10,
                  shadowColor: Colors.red,
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.message_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
