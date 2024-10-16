import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/UserStatus.dart';
import 'package:socialmedia/baseComponents/UserStatusChatroom.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/appLifeCycle.dart';

class Chatroom extends StatelessWidget {
  UserModel? user;
  final messageController = TextEditingController();
  final appLifecycleController = Get.find<AppLifecycleController>();

  Chatroom({
    super.key,
    required this.user,
  });
  final Chatroomcontroller chatController = Get.put(Chatroomcontroller());

  @override
  Widget build(BuildContext context) {
    String chatroomId =
        Services.getChatroomId(Sessioncontroller.userid.toString(), user!.uid);

    chatController.listenToMessages(chatroomId, user!.uid);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white30,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.images.bg.path), fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
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
                        profileImage(profile: user!.profile, height: 50, width: 50),
                        Positioned(
                                                        right: -2,
                                                        bottom: 2,
                                                        child: UserStatus(user),
                                                      ),
                      ],
                    ),
                    SB.w(30),
                    UserStatusChatroom(user),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatController.messagesList.length + 1,
                    itemBuilder: (context, index) {
                      log(chatController.messagesList.length.toString());
                      if (index == chatController.messagesList.length) {
                        // Load more messages only if `finish` is false
                        if (!chatController.finish.value) {
                          chatController.updatecounter();
                          chatController.listenToMessages(
                              chatroomId, user!.uid.toString());
                        }

                        // Show a loading spinner or "No more messages" message
                        return Center(
                          child: chatController.finish.value
                              ? const Text(
                                  'No more messages',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeCap: StrokeCap.round,
                                ),
                        );
                      }

                      final Message message =
                          chatController.messagesList[index];
                      bool isSender = message.senderId ==
                          Sessioncontroller.userid.toString();

                      return MessageBox(
                        isSender: isSender,
                        message: message,
                        isMessageSent: chatController.isMessageSent.value,
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFieldWidget(
                      prefixIcon: const Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.black38,
                      ),
                      hintText: 'Message',
                      controller: messageController,
                      fillColor: Colors.white,
                      borderRadius: 50,
                      maxLines: 1,
                      cursorColor: Colors.black,
                      onChanged: (text) {
                        // Set typing status to true when typing
                        appLifecycleController
                            .updateTypingStatus(text.isNotEmpty);
                      },
                      onFieldSubmittedValue: (value) {
                        // Set typing status to false when done
                        appLifecycleController.updateTypingStatus(
                          false,
                        );
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            chatController.sendMessage(
                              chatroomId,
                              Sessioncontroller.userid.toString(),
                              user!.uid,
                              messageController.text.trim(),
                            );
                            messageController.clear();
                            // Set typing status to false after sending
                            appLifecycleController.updateTypingStatus(false);
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
