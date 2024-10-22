import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/checkedInView/controller/checkedinViewController.dart';
import 'package:socialmedia/view/mapScreen/viewModels/checkedInLocationModel.dart';

class Checkedinview extends StatelessWidget {
  String? userid;

  Checkedinview({
    super.key,
    required this.userid,
  });

  final GlobalCheckedinviewcontroller globalCheckedinviewcontroller =
      Get.put(GlobalCheckedinviewcontroller());

  @override
  Widget build(BuildContext context) {
    globalCheckedinviewcontroller.listentoCheckIns(userid!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checked-Ins"),
        leading: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Obx(
        () => globalCheckedinviewcontroller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : globalCheckedinviewcontroller.checkeInLocationlist.isEmpty
                ? Center(
                    child: Text(
                      'No Locations Added',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: globalCheckedinviewcontroller
                        .checkeInLocationlist.length,
                    itemBuilder: (context, index) {
                      final CheckedInLocation checkedInLocation =
                          globalCheckedinviewcontroller
                              .checkeInLocationlist[index];
                      return Dismissible(
                        key: Key(checkedInLocation.eventId),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          globalCheckedinviewcontroller.deleteCheckInLocation(
                              checkedInLocation.userId,
                              checkedInLocation.eventId);
                          globalCheckedinviewcontroller.checkeInLocationlist
                              .removeAt(index);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Location deleted')),
                          );
                        },
                        child: Card(
                          elevation: 20,
                          color: Color(0xFFF7F29B),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    clipBehavior: Clip.hardEdge,
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.amber,
                                            offset: Offset(0, 4),
                                            blurRadius: 15,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: checkedInLocation.imageUrl,
                                      //width: context.width * 0.5,
                                      placeholder: (context, url) => SizedBox(
                                          //width: context.width * 0.5,
                                          child: Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.greenAccent,
                                        child: Container(
                                          //width: context.width * 0.5,
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Adjust as needed
                                          ),
                                        ),
                                      )),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error,
                                              color: Colors.red), // Error icon
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120,
                                    //width: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.amber,
                                            offset: Offset(0, 4),
                                            blurRadius: 15,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust as needed
                                        border: Border.all(
                                            width: 1, color: Colors.amber)),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "🏷️  ${checkedInLocation.placeName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            Text(
                                              "🌟 ${checkedInLocation.storyline}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            SizedBox(
                                                width: context.width * 0.54,
                                                child: Text(
                                                    "📍 ${checkedInLocation.address}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                Colors.black)))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
