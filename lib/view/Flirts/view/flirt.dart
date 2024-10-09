import 'package:flutter/material.dart';

import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/requestedUserController.dart';
import 'package:socialmedia/view/Flirts/controller/flirtdetailController.dart';


class UserSwiper extends StatelessWidget {
  final Flirtcontroller flirtcontroller = Get.put(Flirtcontroller());
  final Requestedusercontroller requestedusercontroller = Get.put(Requestedusercontroller());
  //final UserController userController = Get.find();
  final Flirtdetailcontroller flirtdetailcontroller =
      Get.put(Flirtdetailcontroller());

  final CardSwiperController swiperController = CardSwiperController();

  UserSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flirts'),
          leading:
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                color: Colors.black,
                height: context.height * 0.7,
                width: context.width * 0.9,
                child: flirtcontroller.userList.isEmpty
                    ? const Text('No Flirts Available')
                    : CardSwiper(
                        duration: const Duration(milliseconds: 1000),
                        allowedSwipeDirection:
                            const AllowedSwipeDirection.symmetric(
                                horizontal: true, vertical: true),
                        controller: swiperController,
                        backCardOffset: const Offset(0, -50),
                        padding: EdgeInsets.zero,
                        numberOfCardsDisplayed:
                            flirtcontroller.userList.length > 3
                                ? 3
                                : flirtcontroller.userList.length,
                        cardsCount: flirtcontroller.userList.length,
                        isLoop: false,
                        onSwipe: (previousIndex, currentIndex, direction) {
                          if (currentIndex != null) {
                            // cont.currentIndex.value = currentIndex;

                            if (direction == CardSwiperDirection.right) {
                              log("on swip right.......");
                            } else if (direction == CardSwiperDirection.left) {
                              log("on swip left.......");
                            }

                            return true;
                          }
                          return true;
                        },
                        cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) {
                          UserModel user = flirtcontroller.userList[index];

                          return GestureDetector(
                            onTap: () async {
                              await flirtdetailcontroller
                                  .extractColors(user.profile);
                              await requestedusercontroller.fetchRequestedUserData(user.uid); 
                              Get.to(() => Flirtdetailscreen(data: user));
                            },
                            child: Container(
                                //height: 200,
                                //width: 200,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 4),
                                        blurRadius: 15,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(user.profile),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Container(
                                        width: context.width,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            color: Colors.white54),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            //mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                  user.username.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 18,
                                                            color: Colors.black),
                                                  ),
                                                  user.age==null? SizedBox():Text(
                                                "  ${user.age.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 18,
                                                            color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                    '${user.country}, ${user.state}, ${user.city}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: Colors.black),
                                                  ),
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                          );
                        }),
              ),
            )
          ],
        ));
  }
}







// Obx(() {
//         if (controller.userList.isEmpty) {
//           return const Center(child: CircularProgressIndicator()); // Show loading indicator if userList is empty
//         }
        
//         return ListView.builder(
//           itemCount: controller.userList.length,
//           itemBuilder: (context, index) {
//             UserModel user = controller.userList[index]; // Get the user at the current index
//             return user.uid.toString() == Sessioncontroller.userid.toString()? const SizedBox():Card(
//               margin: const EdgeInsets.all(10),
//               child: 
              
//               ListTile(
//                 contentPadding: const EdgeInsets.all(15),
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(user.profile), // Assuming profile is a URL
//                 ),
//                 title: Text(user.username),
//                 subtitle: Text(user.bio ?? 'No bio available'), // Display bio or default text
//                 trailing: Icon(
//                   user.isOnline == 'true' ? Icons.circle : Icons.circle_outlined,
//                   color: user.isOnline == 'true' ? Colors.green : Colors.grey,
//                 ),
//                 onTap: () {
//                   // Navigate to user detail screen on tap
                  
//                 },
//               ),
//             );
//           },
//         );
//       }),