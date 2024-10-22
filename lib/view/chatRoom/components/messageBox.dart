import 'package:flutter/material.dart';
import '../../../services/imports.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    super.key,
    required this.isSender,
    required this.message,

  });

  final bool isSender;
  final Message message;

  final Chatroomcontroller chatController = Get.put(Chatroomcontroller());

  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            //width: context.width*0.5,
            //height: context.height*0.05,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: isSender ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: Radius.circular(isSender ? 10 : 0),
                    bottomRight: Radius.circular(isSender ? 0 : 10))),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(message.content,
                    style: TextStyle(
                        color: isSender ? Colors.white : Colors.black,
                        fontSize: 16)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: isSender
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      Timegetter.formatTimestamp(message.timestamp.toString()),
                      style: TextStyle(
                          color: isSender ? Colors.white70 : Colors.amber,
                          fontSize: 10),
                    ),
                    if (isSender) ...[
                      const SizedBox(width: 3),
                      buildMessageStatus(message),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageStatus(Message message) {
    switch (message.status) {
      case MessageStatus.notDelivered:
        return const Icon(Icons.done, color: Colors.grey); // Single tick
      case MessageStatus.delivered:
        return const Icon(Icons.done_all, color: Colors.grey);
      case MessageStatus.seen:
        return const Icon(Icons.done_all, color: Colors.amber);
    }
  }
}
