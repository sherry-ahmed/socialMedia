import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:socialmedia/baseComponents/imports.dart';

import 'package:socialmedia/view/Flirts/controller/flirtController.dart';
import 'package:socialmedia/view/Flirts/view/flirtDetailScreen.dart';

class UserSwiper extends StatelessWidget {
  final Flirtcontroller flirtcontroller = Get.put(Flirtcontroller());
  //final UserController userController = Get.find();

  final CardSwiperController swiperController = CardSwiperController();


  UserSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flirts'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                color: Colors.black,
                height: context.height * 0.5,
                width: context.width * 0.9,
                child: flirtcontroller.userList.isEmpty
                    ? const Text('No Flirts Available')
                    : CardSwiper(
                        duration: const Duration(milliseconds: 500),
                        allowedSwipeDirection:
                            const AllowedSwipeDirection.symmetric(
                                horizontal: true),
                        controller: swiperController,
                        backCardOffset: const Offset(0, -35),
                        padding: EdgeInsets.zero,
                        numberOfCardsDisplayed:
                            flirtcontroller.userList.length > 5
                                ? 5
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
                            onTap: () {
                              Get.to(() => Flirtdetailscreen(data: user));
                            },
                            child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey, // Shadow color
                                        offset: Offset(0, 4), // Shadow position
                                        blurRadius:
                                            8, // How much the shadow should be blurred
                                        spreadRadius:
                                            5, // How much the shadow should spread
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
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.black38),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${user.username} 18\n${user.bio}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          )),
                                    )
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