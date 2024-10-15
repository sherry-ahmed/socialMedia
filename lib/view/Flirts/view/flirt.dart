import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class UserSwiper extends StatelessWidget {
  final Flirtcontroller flirtcontroller = Get.put(Flirtcontroller());
  
  final Flirtdetailcontroller flirtdetailcontroller =
      Get.put(Flirtdetailcontroller());
  final CardSwiperController swiperController = CardSwiperController();

  UserSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flirts'),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
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
                      duration: const Duration(milliseconds: 400),
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
                          if (direction == CardSwiperDirection.right) {
                            log("on swipe right....");
                          } else if (direction == CardSwiperDirection.left) {
                            log("on swipe left....");
                          }
                          return true;
                        }
                        return true;
                      },
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        UserModel user = flirtcontroller.userList[index];

                        return GestureDetector(
                          onTap: ()  {
                            flirtdetailcontroller.checkfriend(Sessioncontroller.userid.toString(), user.uid);
                            flirtdetailcontroller.checkrequest(Sessioncontroller.userid.toString(), user.uid);

                            Get.to(() => Flirtdetailscreen(data: user));
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
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
                            ),
                            child: Stack(
                              children: [
                                // Network image with progress indicator
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: user.profile,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.shade700,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                            child: Icon(Icons.wifi_off)),
                                  ),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Container(
                                      width: context.width,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        color: Colors.white54,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                user.age == null
                                                    ? SizedBox()
                                                    : Text(
                                                        "  ${user.age.toString()}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                            ),
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
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
