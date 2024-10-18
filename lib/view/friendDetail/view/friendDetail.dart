import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/friendDetail/component/column1.dart';
import 'package:socialmedia/view/friendDetail/component/popUpmenu.dart';
import 'package:socialmedia/view/friendDetail/controller/friendDetailController.dart';

class Frienddetail extends StatelessWidget {
  UserModel? user;

  Frienddetail({super.key, required this.user});
  final Frienddetailcontroller frienddetailcontroller =
      Get.put(Frienddetailcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: const [FriendDetailPopupMenu()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 20,
                shadowColor: Colors.amber,
                child: user!.profile.isEmpty
                    ? Assets.images.womenPeekingOut
                        .image(fit: BoxFit.cover, height: 120, width: 120)
                    : profileImage(
                        profile: user!.profile, height: 120, width: 120),
              ),
              SB.h(20),
              Text(
                user!.username,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                user!.phone.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey),
              ),
              SB.h(10),
              Row(
                children: [
                  const Column1(
                    text: 'Audio',
                    icon: Icon(Icons.call),
                  ),
                  SB.w(10),
                  const Column1(
                    text: 'Video',
                    icon: Icon(Icons.video_call),
                  ),
                  SB.w(10),
                  const Column1(
                    text: 'search',
                    icon: Icon(Icons.search),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: context.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.bio.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 14),
                          ),
                          Text(Timegetter.formatDateOfBirth(user!.dateOfBirth)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: context.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Media",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 14),
                          ),
                          Row(
                            children: [
                              user!.fbLink != ''
                                  ? GestureDetector(
                                      onTap: () {
                                        Services.launchURL(user!.fbLink);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 6),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 15,
                                            child: Image.asset(
                                              Assets.icons.facebookPng.path,
                                              height: 20,
                                              width: 20,
                                            )),
                                      ),
                                    )
                                  : const SizedBox(),
                              user!.instaLink != ''
                                  ? GestureDetector(
                                      onTap: () {
                                        Services.launchURL(user!.instaLink);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 6),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 15,
                                            child: Image.asset(
                                              Assets.icons.instaColoured.path,
                                              height: 20,
                                              width: 20,
                                            )),
                                      ),
                                    )
                                  : const SizedBox(),
                              user!.tiktokLink != ''
                                  ? GestureDetector(
                                      onTap: () {
                                        Services.launchURL(user!.tiktokLink);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 6),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 15,
                                            child: Image.asset(
                                              Assets.icons.twitterColoured.path,
                                              height: 20,
                                              width: 20,
                                            )),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: context.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7.0, horizontal: 4),
                          child: Row(
                            children: [
                              //SB.w(12),
                              const Icon(Icons.lock, color: Colors.white60),
                              const SizedBox(width: 10),
                              Text('Chatlock',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Spacer(),
                              Obx(
                                () => Switch(
                                  value: frienddetailcontroller.chatlock.value,
                                  onChanged: (value) {
                                    frienddetailcontroller
                                        .togglechatlock(); // Toggle the lock
                                    log(value.toString());
                                  },
                                  activeColor:
                                      Colors.amber, // Color when the switch is ON
                                  inactiveThumbColor:
                                      Colors.grey, // Color when the switch is OFF
                                  splashRadius: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 4),
                            child: Obx(
                              () => GestureDetector(
                                onTap: () {
                                  frienddetailcontroller.togglefavourite();
                                },
                                child: Row(
                                  children: [
                                    frienddetailcontroller.favourite.value
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.amber,
                                            )
                                          : const Icon(Icons.favorite_border,
                                              color: Colors.white60),
                                    
                                    const SizedBox(width: 10),
                                    Text(
                                      'Favourties',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.white60,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Disappearing Messages',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications,
                                color: Colors.white60,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Notification Settings',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: context.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.block,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'UnFriend ${user!.username}',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.thumb_down,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Report ${user!.username}',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:50.0),
                  child: Row(children: [
                    Assets.images.pets.image(width: 35,height: 35),
                    SB.w(15),
                    Text('Developers',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white))
                  ],),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


