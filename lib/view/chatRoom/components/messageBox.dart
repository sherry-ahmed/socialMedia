import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/timeGetter.dart';

import '../../../baseComponents/imports.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    super.key,
    required this.isSender,
    required this.message,
    required this.isMessageSent,
  });

  final bool isSender;
  final Message message;
  final bool isMessageSent;
  final Chatroomcontroller chatController = Get.put(Chatroomcontroller());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          Container(
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
                Text(message.content,
                    style:
                        TextStyle(color: isSender ? Colors.white : Colors.black)),
                
              ],

            ),
          ),
          Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Text(
                      Timegetter.formatTimestamp(message.timestamp.toString()),
                      style: TextStyle(
                          color: isSender ? Colors.white70 : Colors.amber,
                          fontSize: 10),
                    ),
                    if (isSender) ...[
                      const SizedBox(width: 3),
                      Obx(
                        () => Icon(
                          chatController.isMessageSent.value
                              ? Icons.done_all
                              : Icons.done,
                          size: 16,
                          color: chatController.isMessageSent.value
                              ? Colors.yellow
                              : Colors.white70,
                        ),
                      ),
                    ],
                  ],
                ),
        ],
      ),
    );
  }
}
