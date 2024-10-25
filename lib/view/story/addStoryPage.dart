import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/story/component/circularImage.dart';
import 'package:socialmedia/view/story/storyController.dart';
import 'package:socialmedia/view/story/storyview.dart';
import 'package:video_player/video_player.dart';

class AddStoryPage extends StatefulWidget {
  @override
  _AddStoryPageState createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final AddStoryController _storyController = Get.put(AddStoryController());
  final userController = Get.find<UserController>();
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedMedia = []; // List to hold multiple media
  List<String> captions = []; // List to hold captions for each media
  VideoPlayerController? _videoController;
  final captionController = TextEditingController();

  // Function to pick image or video
  Future<void> pickMedia() async {
    // Open media picker directly without a bottom sheet
    final pickedMedia = await showDialog<XFile>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Media'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Open Camera"),
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop(image);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Select Image"),
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop(image);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text("Record Video"),
                onTap: () async {
                  final XFile? video =
                      await _picker.pickVideo(source: ImageSource.camera);
                  Navigator.of(context).pop(video);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text("Select Video"),
                onTap: () async {
                  final XFile? video =
                      await _picker.pickVideo(source: ImageSource.gallery);
                  Navigator.of(context).pop(video);
                },
              ),
            ],
          ),
        );
      },
    );

    // If a media item is selected, save it
    if (pickedMedia != null) {
      setState(() {
        selectedMedia.add(pickedMedia);
        captions.add(''); // Initialize a new caption entry
      });
    }
  }

  // Function to handle story upload
  void uploadStory() async {
    if (selectedMedia.isNotEmpty) {
      await _storyController.uploadStory(
        userId: Sessioncontroller.userid.toString(),
        mediaFiles: selectedMedia,
        captions: captions, // Pass the list of captions
        isTextStory: captions.isNotEmpty && captions.any((caption) => caption.isNotEmpty),
      );

      // Clear selected media and captions after upload
      setState(() {
        selectedMedia.clear();
        captions.clear(); // Clear captions as well
        captionController.clear(); // Clear the controller
      });
    }
  }

  // Function to remove media from the list
  void removeMedia(XFile media) {
    int index = selectedMedia.indexOf(media);
    if (index != -1) {
      setState(() {
        selectedMedia.remove(media);
        captions.removeAt(index); // Remove the corresponding caption
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    captionController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: selectedMedia.isNotEmpty
                ?0.0:context.width*0.08),
        child: Stack(
          children: [
            // Display the latest selected media if available
            selectedMedia.isNotEmpty
                ? isVideo(selectedMedia.last)
                    ? Container(
                        height: context.height,
                        child: VideoPreview(file: selectedMedia.last))
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context)
                            .size
                            .height, // Force height for the image
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(selectedMedia.last.path)),
                            fit: BoxFit
                                .cover, // Make sure the image fits within the container
                          ),
                        ),
                      )
                : Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickMedia();
                      },
                      child: CircularNetworkImage(imageUrl: userController.currentUser.value.profile)),
                      Obx(
        () {
          if (_storyController.friendStories.isEmpty) {
            return Center(child: Text("No stories to show."));
          }

          return _storyController.isLoading.value? Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white,),)):Expanded(
            child: ListView.builder(
              itemCount: _storyController.friendStories.length,
              itemBuilder: (context, index) {
                final story = _storyController.friendStories[index];
            
                return ListTile(
                  title: Text("Story by ${story.userId}", style: TextStyle(color: Colors.white),),
                  onTap: () {
                    //Navigate to StoryViewPage
                    Get.to(() => Storyview(storyChunks: story.chunks));
                  },
                );
              },
            ),
          );
        })
                      
                  ],
                  
                ),
            selectedMedia.isNotEmpty
                ?Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.black38),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Display selected media in a horizontal list
                    if (selectedMedia.isNotEmpty)
                      Container(
                        height: 70, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedMedia.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                              File(selectedMedia[index].path)),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1, color: Colors.white)),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    onPressed: () => removeMedia(selectedMedia[index]), // Remove media from list
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    // Show TextField for caption input only if media is selected
                    if (selectedMedia.isNotEmpty)
                      TextField(
                        controller: captionController,
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          // Update the caption in the captions list for the current index
                          int index = selectedMedia.length - 1; // Get the current media index
                          captions[index] = value; // Update caption for the current media
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Add a caption...",
                          prefixIcon: IconButton(
                            icon: Icon(Icons.add_a_photo, color: Colors.amber),
                            onPressed: () {
                              captionController.clear();
                              pickMedia();
                            }, // Open media picker
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.amber),
                            onPressed: uploadStory, // Upload story
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.amber,
                                width: 1.0), // Border color when enabled
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Colors.amber,
                                width: 2.0), // Border color when focused
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }

  // Helper to check if the file is a video
  bool isVideo(XFile file) {
    return file.path.endsWith('.mp4') ||
        file.path.endsWith('.mov') ||
        file.path.endsWith('.avi');
  }
}

// Video preview widget
class VideoPreview extends StatefulWidget {
  final XFile file;
  VideoPreview({required this.file});

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file.path))
      ..initialize().then((_) {
        setState(() {}); // Update UI when video is ready
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}
