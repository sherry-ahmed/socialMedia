import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/story/storyModel.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class Storyview extends StatelessWidget {
  final StoryController controller = StoryController();
  final List<StoryChunk> storyChunks; // List to hold the received story chunks

  Storyview({Key? key, required this.storyChunks}) : super(key: key); // Constructor to receive story chunks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Container(
              height: context.height*0.95,
              width: context.width,
              child: StoryView(
                controller: controller,
                storyItems: storyChunks.map((chunk) {
                  if (chunk.type == 'image') {
                    return StoryItem.inlineImage(
                      url: chunk.mediaUrl,
                      controller: controller,
                      caption: Text(
                        chunk.caption,
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                    );
                  } else if (chunk.type == 'video') {
                    return StoryItem.pageVideo(
                      chunk.mediaUrl,
                      controller: controller,
                      caption: Text(
                        chunk.caption,
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                    );
                  } else {
                    return StoryItem.text(
                      title: "Unsupported media type",
                      backgroundColor: Colors.red,
                      roundedTop: true,
                    );
                  }
                }).toList(), // Build storyItems based on storyChunks
                onStoryShow: (storyItem, index) {
                  log("Showing a story");
                },
                onComplete: () {
                  log("Completed a cycle");
                  Get.back();
                },
                progressPosition: ProgressPosition.top,
                repeat: false,
                inline: true,
              ),
            ),
            // Material(
            //   child: InkWell(
            //     onTap: () {
            //       // Handle view more stories action
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.black54,
            //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
            //       padding: EdgeInsets.symmetric(vertical: 8),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Icon(
            //             Icons.arrow_forward,
            //             color: Colors.white,
            //           ),
            //           SizedBox(width: 16),
            //           Text(
            //             "View more stories",
            //             style: TextStyle(fontSize: 16, color: Colors.white),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
