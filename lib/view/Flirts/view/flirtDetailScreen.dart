import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/requestedUserController.dart';
import 'package:socialmedia/services/connection.dart';
import 'package:socialmedia/view/Flirts/components/blockReport.dart';
import 'package:socialmedia/view/Flirts/controller/flirtdetailController.dart';

class Flirtdetailscreen extends StatelessWidget {
  Flirtdetailscreen({super.key, required this.data});
  final UserModel data;
  final Flirtdetailcontroller controller = Get.put(Flirtdetailcontroller());
  final userController = Get.find<UserController>();
  final Requestedusercontroller requestedusercontroller = Get.put(Requestedusercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          boxShadow: [
                            BoxShadow(
                              color: controller.dominantColor,
                              spreadRadius: 12,
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            )
                          ]),
                      child: Image.network(
                        requestedusercontroller.requestedUser.value.profile,
                        //fit: BoxFit.fill,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Column(
                        children: [
                          data.fbLink != ''
                              ? GestureDetector(
                                  onTap: () {
                                    controller.launchURL(requestedusercontroller
                                        .requestedUser.value.fbLink);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
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
                                    controller.launchURL(requestedusercontroller
                                        .requestedUser.value.instaLink);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
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
                                    controller.launchURL(requestedusercontroller
                                        .requestedUser.value.tiktokLink);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
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
                    requestedusercontroller.requestedUser.value.username
                        .toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  data.age == null
                      ? SizedBox()
                      : Text(
                          "  ${requestedusercontroller.requestedUser.value.age.toString()}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                ],
              ),
              Text(
                requestedusercontroller.requestedUser.value.bio.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 16, color: Colors.black),
              ),
              Wrap(
                spacing: 8.0, // Add spacing between the items
                runSpacing: 8.0, // Add spacing between rows
                children: List.generate(
                  requestedusercontroller.requestedUser.value.hobbies!.length,
                  (index) => IntrinsicWidth(
                    child: Card(
                      elevation: 5,
                      shadowColor: controller.dominantColor,
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
                              requestedusercontroller
                                  .requestedUser.value.hobbies![index]
                                  .toString(),
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
                Utils.toastMessage('Location Uavailable');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 10,
                shadowColor: controller.dominantColor,
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
            GestureDetector(
              onTap: () {
                requestedusercontroller.requestedUser.value.requests!
                            .contains(userController.currentUser.value.uid) ||
                        userController.currentUser.value.friends!
                            .contains(data.uid.toString())
                    ? Connection.withdrawRequest()
                    : Connection.sendrequest();
              },
              child: Obx(
                  () => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 10,
                shadowColor: controller.dominantColor,
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: requestedusercontroller.requestedUser.value.requests!.contains(
                                userController.currentUser.value.uid) ||
                            userController.currentUser.value.friends!
                                .contains(data.uid)
                        ? Colors.black
                        : Colors.white,
                    child: Icon(
                      Icons.person_add,
                      color: requestedusercontroller.requestedUser.value.requests!.contains(
                                  userController.currentUser.value.uid) ||
                              userController.currentUser.value.friends!
                                  .contains(data.uid)
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
                // Get.to(()=>Chatroom(profile: data.profile, username: data.username, receiverUID: data.uid) );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 10,
                shadowColor: controller.dominantColor,
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
    );
  }
}
