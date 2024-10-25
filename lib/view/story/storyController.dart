import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/story/storyModel.dart';

class AddStoryController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAndListenToFriendStories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadStory({
    required String userId,
    required List<XFile> mediaFiles,
    required List<String> captions,
    bool isTextStory = false,
    String? textStory,
  }) async {
    final String storyId = DateTime.now().millisecondsSinceEpoch.toString();
    final List<StoryChunk> chunks = [];

    try {
      log(mediaFiles.toString());
      log('media upload started');
      for (int i = 0; i < mediaFiles.length; i++) {
        final XFile file = mediaFiles[i];
        final String caption = captions.length > i ? captions[i] : '';
        final String type =
            file.path.endsWith('.mp4') || file.path.endsWith('.mov')
                ? 'video'
                : 'image';

        log('started upload for file $i of type $type');
        log('started$i');

        final ref =
            _storage.ref().child('stories/$userId/${storyId}/${storyId}${i}');
        await ref.putFile(File(file.path)).then((value) {
          log('uploaded$i');
        }).onError((error, stacktrace) {
          log('upload error: $error');
        });

        final String mediaUrl = await ref.getDownloadURL();

        chunks
            .add(StoryChunk(mediaUrl: mediaUrl, caption: caption, type: type));
      }

      if (isTextStory && textStory != null && textStory.isNotEmpty) {
        chunks.add(StoryChunk(mediaUrl: '', caption: textStory, type: 'text'));
      }

      final Story story = Story(
        storyId: storyId,
        userId: userId,
        createdAt: DateTime.now(),
        chunks: chunks,
      );

      await _firestore
          .collection('StorySystem')
          .doc(userId)
          .collection('stories')
          .doc(storyId)
          .set(story.toMap());
      Get.back();
    } catch (e) {
      print("Error uploading story: $e");
    }
  }

  RxList<Story> friendStories = <Story>[].obs;
  final Homecontroller homeController = Get.find<Homecontroller>();
  RxBool isLoading = false.obs;

  Future<void> fetchAndListenToFriendStories() async {
  final friendIds = homeController.friendList.map((friend) => friend.uid).toList();
  friendStories.clear();
  // friendIds.add(Sessioncontroller.userid.toString());

  try {
    isLoading.value = true;
    
    for (String friendId in friendIds) {
      _firestore
          .collection('StorySystem')
          .doc(friendId)
          .collection('stories')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((QuerySnapshot storySnapshot) {
        // Clear previous stories from this friend before adding the new set
        friendStories.removeWhere((story) => story.userId == friendId);

        List<Story> stories = storySnapshot.docs.map((doc) {
          return Story(
            storyId: doc['storyId'],
            userId: doc['userId'],
            createdAt: DateTime.fromMillisecondsSinceEpoch(doc['createdAt']),
            chunks: List<StoryChunk>.from(
              (doc['chunks'] as List).map(
                (chunk) => StoryChunk(
                  mediaUrl: chunk['mediaUrl'],
                  caption: chunk['caption'],
                  type: chunk['type'],
                ),
              ),
            ),
          );
        }).toList();

        // Add stories to the friendStories list
        friendStories.addAll(stories);
        isLoading.value = false;
      });
    }
  } catch (e) {
    print("Error fetching friend stories: $e");
  }
}

}
