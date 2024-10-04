import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/timeGetter.dart';
import 'package:socialmedia/view/chatRoom/controller/chatRoomController.dart';
import 'package:socialmedia/view/chatRoom/viewModel/messageModel.dart';

import '../../../baseComponents/imports.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    super.key,
    required this.isSender,
    required this.message,
    required this.isMessageSent, // New parameter for single/double tick
  });

  final bool isSender;
  final Message message;
  final bool isMessageSent; // Track if the message is uploaded to Firebase
  final Chatroomcontroller chatController = Get.put(Chatroomcontroller());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: isSender ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(isSender ? 15 : 0),
                bottomRight: Radius.circular(isSender ? 0 : 15))),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message content
            Text(message.content,
                style:
                    TextStyle(color: isSender ? Colors.white : Colors.black)),

            // Time and Tick icons
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                // Timestamp below the message
                Text(
                  Timegetter.formatTimestamp(message.timestamp.toString()),
                  style: TextStyle(
                      color: isSender ? Colors.white70 : Colors.black87,
                      fontSize: 10),
                ),

                // Ticks for message status (Single, Double, Blue)
                if (isSender) ...[
                  const SizedBox(width: 3), // Add space between time and tick
                  Obx(
                    () => Icon(
                      chatController.isMessageSent.value
                          ? Icons.done_all // Blue double tick when read

                          : Icons.done, // Single tick before upload
                      size: 16,
                      color: chatController.isMessageSent.value
                          ? Colors.yellow // Blue tick if read
                          : Colors.white70, // Gray tick if not read
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
