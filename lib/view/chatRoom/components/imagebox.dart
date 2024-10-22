import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Imagebox extends StatelessWidget {
  Imagebox({
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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: Radius.circular(isSender ? 10 : 0),
                bottomRight: Radius.circular(isSender ? 0 : 10),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageBoxContent(
                    imageUrl: message.content.toString(),
                    isSender: isSender,
                  ),
                ),
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

class ImageBoxContent extends StatefulWidget {
  final String imageUrl;
  final bool isSender;

  const ImageBoxContent(
      {Key? key, required this.imageUrl, required this.isSender})
      : super(key: key);

  @override
  _ImageBoxContentState createState() => _ImageBoxContentState();
}

class _ImageBoxContentState extends State<ImageBoxContent> {
  // double _downloadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      width: context.width * 0.5,
      placeholder: (context, url) => SizedBox(
        width: context.width * 0.5,
        child: Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: Colors.white,
          child: Container(
            width: context.width * 0.5,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0), // Adjust as needed
            ),
          ),
        )
      ),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: Colors.red), // Error icon
    );
  }
}
