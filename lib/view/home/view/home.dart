import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Home extends StatelessWidget {
  final searchController = TextEditingController();
  final currentUserController = Get.find<UserController>();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GetBuilder<Homecontroller>(
              init: Homecontroller(),
              builder: (controller) {
                return Column(
                  children: [
                    AnimatedContainer(
                      curve: Curves.easeIn,
                      height: controller.showsearchbar.value ? 60 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: controller.showsearchbar.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofocus: false,
                                maxLines: 1,
                                controller: searchController,
                                cursorColor: Colors.black,
                                onChanged: (value) {
                                  searchController.text = value;
                                  controller.update();
                                },
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 12),
                                  fillColor: Colors.white,
                                  hintText: 'search',
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      controller.searchbar(false);
                                      controller.update(); // Close search bar
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    !controller.showsearchbar.value
                        ? SizedBox(
                            height: 70,
                            child: Row(
                              children: [
                                SB.w(12),
                                Text(
                                  'Friends',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle,
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
                                    const HomePopupMenu()
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox(),
                    SB.h(30),
                    Expanded(
                      child: controller.friendList.isEmpty
                          ? const Center(
                              child: Text(
                              'No Friends',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 25),
                            ))
                          : ListView.builder(
                              itemCount: controller.friendList.length,
                              itemBuilder: (context, index) {
                                UserModel user = controller.friendList[index];
                                final username = user.username;

                                if (searchController.text.isEmpty ||
                                    username.toLowerCase().contains(
                                        searchController.text.toLowerCase())) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => Chatroom(
                                            user: user,
                                          ));
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
                                            user.profile.isEmpty
                                                ? Stack(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors.black,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                    Assets
                                                                        .images
                                                                        .user
                                                                        .path)
                                                                as ImageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: -2,
                                                        bottom: 2,
                                                        child: UserStatus(user),
                                                      ),
                                                    ],
                                                  )
                                                : Stack(
                                                    children: [
                                                      profileImage(
                                                          profile: user.profile,
                                                          height: 50,
                                                          width: 50),
                                                      Positioned(
                                                          right: -2,
                                                          bottom: 2,
                                                          child:
                                                              UserStatus(user)),
                                                    ],
                                                  ),
                                            SB.w(20),
                                            // User Info
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user.username,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                Text(
                                                  user.email,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: StreamBuilder<int>(
                                                stream: controller
                                                    .getUnreadMessageCount(
                                                        Services.getChatroomId(
                                                            Sessioncontroller
                                                                .userid
                                                                .toString(),
                                                            user.uid),
                                                        Sessioncontroller.userid
                                                            .toString()),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData &&
                                                      snapshot.data! > 0) {
                                                    return Container(
                                                      height: 7,
                                                      width: 7,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.black),
                                                      child: Center(
                                                        child: Text(
                                                          "${snapshot.data!}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(); // No unread messages
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
