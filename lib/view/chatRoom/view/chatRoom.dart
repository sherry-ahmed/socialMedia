import 'package:flutter/material.dart';
import 'package:socialmedia/services/UserStatusChatroom.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/chatRoom/components/chatPopUpmenu.dart';
import 'package:socialmedia/view/chatRoom/components/imagebox.dart';
import 'package:socialmedia/view/chatRoom/components/voicenote.dart';
import 'package:socialmedia/view/friendDetail/view/friendDetail.dart';

class Chatroom extends StatelessWidget {
  UserModel? user;

  Chatroom({
    super.key,
    required this.user,
  });

  final messageController = TextEditingController();

  final appLifecycleController = Get.find<AppLifecycleController>();

  final Chatroomcontroller chatController = Get.put(Chatroomcontroller());

  @override
  Widget build(BuildContext context) {
    String chatroomId =
        Services.getChatroomId(Sessioncontroller.userid.toString(), user!.uid);
    chatController.markMessagesAsSeen(chatroomId);
    chatController.listenToMessages(chatroomId, user!.uid);

    // chatController.checkFriendship(
    //     Sessioncontroller.userid.toString(), user!.uid);
    chatController.resetUnreadMessageCount(
        chatroomId, Sessioncontroller.userid.toString());
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          //chatController.isuploading.value=false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white30,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.bg.path),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => Frienddetail(user: user));
                  },
                  child: Container(
                    height: 65,
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        Stack(
                          children: [
                            profileImage(
                                profile: user!.profile, height: 50, width: 50),
                            Positioned(
                              right: -2,
                              bottom: 2,
                              child: UserStatus(user),
                            ),
                          ],
                        ),
                        SB.w(30),
                        UserStatusChatroom(user),
                        const Expanded(
                            child: Icon(
                          Icons.camera_alt,
                          color: Colors.transparent,
                          size: 25,
                        )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.call,
                              color: Colors.amber,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.video_call,
                              color: Colors.amber,
                              size: 30,
                            )),
                        const Chatpopupmenu()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (chatController.messagesList.isEmpty) {
                      return const Center(
                        child: Text(
                          'No messages',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chatController.messagesList.length + 1,
                        itemBuilder: (context, index) {
                          log(chatController.messagesList.length.toString());
                          if (index == chatController.messagesList.length) {
                            if (chatController.hasMoreMessages.value) {
                              chatController.updatecounter();
                              chatController.listenToMessages(
                                  chatroomId.toString(), user!.uid.toString());

                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeCap: StrokeCap.round,
                                ),
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  'No more messages',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                          }

                          final Message message =
                              chatController.messagesList[index];
                          bool isSender = message.senderId ==
                              Sessioncontroller.userid.toString();

                          return message.type == 'text'
                              ? GestureDetector(
                                  onLongPress: () {
                                    chatController.showDeleteConfirmationDialog(
                                        context, chatroomId, message);
                                  },
                                  child: MessageBox(
                                    isSender: isSender,
                                    message: message,
                                  ),
                                )
                              : message.type == 'voicenote'
                                  ? GestureDetector(
                                      onLongPress: () {
                                        chatController
                                            .showDeleteConfirmationDialog(
                                                context, chatroomId, message);
                                      },
                                      child: Voicenote(
                                          isSender: isSender,
                                          message:
                                              message), // Assuming content holds the audio URL
                                    )
                                  : GestureDetector(
                                      onLongPress: () {
                                        chatController
                                            .showDeleteConfirmationDialog(
                                                context, chatroomId, message);
                                      },
                                      child: Imagebox(
                                        isSender: isSender,
                                        message: message,
                                      ),
                                    );
                        },
                      ),
                    );
                  }),
                ),
                Obx(
                  () => chatController.isuploading.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                              height: 35,
                              width: context.width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  'Uploading...',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black),
                                ),
                              )),
                        )
                      : Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 15.0,
                      left: 10,
                      right: 10),
                  child: Obx(() {
                    if (chatController.isFriend.value) {
                      return Row(
                        children: [
                          Expanded(
                            child: chatController.isRecording.value
                                ? const SizedBox()
                                : TextFormField(
                                    controller: messageController,
                                    cursorColor: Colors.black,
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Message',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide.none,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.black38,
                                        size: 20,
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(onPressed: (){
                                             chatController.pickImage(
                                                    ImageSource.gallery,
                                                    chatroomId.toString(),
                                                    Sessioncontroller.userid
                                                        .toString(),
                                                    user!.uid,
                                                    messageController.text
                                                        .trim(),
                                                    'image');
                                          }, icon: const Icon(Icons.attach_file_rounded)),
                                          IconButton(onPressed: (){
                                            chatController.pickImage(
                                                    ImageSource.camera,
                                                    chatroomId.toString(),
                                                    Sessioncontroller.userid
                                                        .toString(),
                                                    user!.uid,
                                                    messageController.text
                                                        .trim(),
                                                    'image');
                                          }, icon: const Icon(Icons.camera_alt))
                                         
                                        ],
                                      ),
                                    ),
                                    onChanged: (text) {
                                      chatController
                                          .toggleTyping(messageController);

                                      appLifecycleController
                                          .updateTypingStatus(text.isNotEmpty);
                                    },
                                    onFieldSubmitted: (value) {
                                      appLifecycleController
                                          .updateTypingStatus(false);
                                    },
                                  ),
                          ),
                          SB.w(5),
                          chatController.typing.value
                              ? CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                            onPressed: () {
                                              final timestamp = DateTime.now()
                                                  .millisecondsSinceEpoch;
                                              if (messageController
                                                  .text.isNotEmpty) {
                                                chatController.sendMessage(
                                                    chatroomId.toString(),
                                                    Sessioncontroller.userid
                                                        .toString(),
                                                    user!.uid,
                                                    messageController.text
                                                        .trim(),
                                                    'text',
                                                    timestamp);
                                                messageController.clear();
                                                appLifecycleController
                                                    .updateTypingStatus(false);
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.send,
                                              size: 25,
                                            ),
                                          ),
                                )
                              : voicemic(context, chatroomId),
                        ],
                      );
                    } else {
                      return SizedBox(
                        child: Text(
                          'No Longer A Friends',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ); // Show nothing if not a friend
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack voicemic(BuildContext context, String chatroomId) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          return Positioned(
            bottom: 0,
            right: 0,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300), // Duration for both opening and closing
              curve: Curves.easeInOut,
              child: Container(
                height: 50,
                width: chatController.isRecording.value ? context.width - 20 : 0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SizedBox(
                  width: context.width,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      Obx(() => Icon(
                            Icons.mic,
                            color: chatController.blinking.value
                                ? Colors.red
                                : Colors.transparent,
                          )),
                      Obx(() => Text(chatController.getFormattedTime())),
                      const Spacer(),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        direction: ShimmerDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.only(right: context.width * 0.2),
                          child: const Text(
                            'Swipe to cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // Set to null instead of SizedBox.shrink()
              ),
                        ),
            );
        }),
        GestureDetector(
          onTap: () {
            chatController.togglerecording();
            if (chatController.isRecording.value) {
              chatController.startRecording();
            } else {
              chatController.stopRecording(
                chatroomId.toString(),
                Sessioncontroller.userid.toString(),
                user!.uid,
                messageController.text.trim(),
                'voicenote',
              );
            }
          },
          onHorizontalDragUpdate: (details) {
            if (details.primaryDelta! < -10) {
              // Swipe left to delete recording
              chatController.deleteRecording();
            }
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(
              chatController.isRecording.value ? Icons.stop : Icons.mic,
              size: 30,
              color:
                  chatController.isRecording.value ? Colors.red : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}



// chatController.stackopen.value
                              //     ? Positioned(
                              //         right: 0,
                              //         bottom: 0,
                              //         child: Container(
                              //           width: 50,
                              //           height: 140,
                              //           decoration: BoxDecoration(
                              //               color: Colors.grey,
                              //               borderRadius:
                              //                   BorderRadius.circular(50)),
                              //           child: const Center(
                              //             child: Column(
                              //               children: [
                              //                 Padding(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 8.0),
                              //                   child: Icon(Icons.lock),
                              //                 ),
                              //                 Icon(Icons.keyboard_arrow_up),
                              //                 Icon(
                              //                   Icons.stop,
                              //                   color: Colors.transparent,
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         ))
                              //     : const SizedBox(),