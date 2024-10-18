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

  const ImageBoxContent({Key? key, required this.imageUrl, required this.isSender}) : super(key: key);

  @override
  _ImageBoxContentState createState() => _ImageBoxContentState();
}

class _ImageBoxContentState extends State<ImageBoxContent> {
  double _downloadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          widget.imageUrl,
          width: context.width * 0.5,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              // Image is fully loaded, return the image widget
              return child;
            } else {
              // Calculate download progress
              _downloadProgress = loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : 0;

              return SizedBox(
                width: context.width*0.5,
                child: Center(
                  child: CircularProgressIndicator(
                    value: _downloadProgress, // Show progress indicator
                    valueColor: widget.isSender? const AlwaysStoppedAnimation<Color>(Colors.white): const AlwaysStoppedAnimation<Color>(Colors.black) ,
                  ),
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            // Handle image load error
            return const Icon(Icons.error, color: Colors.red); // Error icon
          },
        ),
      ],
    );
  }
}
