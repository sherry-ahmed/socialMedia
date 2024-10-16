import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Chatroom extends StatelessWidget {
  final String profile, username, receiverUID;
  final messageController = TextEditingController();

  Chatroom(
      {super.key,
      required this.profile,
      required this.username,
      required this.receiverUID});
  final Chatroomcontroller chatController = Get.put(Chatroomcontroller());

  @override
  Widget build(BuildContext context) {
    String chatroomId = Services.getChatroomId(
        Sessioncontroller.userid.toString(), receiverUID);

    chatController.listenToMessages(chatroomId, receiverUID);
    

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white30,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  profileImage(profile: profile, height: 40, width: 40),
                  SB.w(30),
                  Text(
                    username,
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.images.bg.path), fit: BoxFit.cover)),
          child: Column(
            children: [
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
                          chatController.listenToMessages(chatroomId,receiverUID);
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
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              chatController.sendMessage(
                                chatroomId,
                                Sessioncontroller.userid.toString(),
                                receiverUID,
                                messageController.text.trim(),
                              );
                              messageController.clear();
                            }
                          },
                          icon: const Icon(Icons.send)),
                    )),
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
