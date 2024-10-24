import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:voice_message_package/voice_message_package.dart';

class Voicenote extends StatefulWidget {
  
   const Voicenote({
    super.key,
    required this.isSender,
    required this.message,
  });

  final bool isSender;
  final Message message;

  @override
  State<Voicenote> createState() => _VoicenoteState();
}

class _VoicenoteState extends State<Voicenote> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          child: VoiceMessageView(
            
            backgroundColor: widget.isSender? Colors.blue: Colors.white,
            activeSliderColor: widget.isSender? Colors.amber: Colors.black,
            circlesColor: widget.isSender? Colors.amber: Colors.black,
            stopDownloadingIcon: const Icon(Icons.pause),
            counterTextStyle: TextStyle(color: widget.isSender? Colors.amber: Colors.black, fontSize: 8),
            size: 30,
            cornerRadius: 15,
            innerPadding: 15,
            
            
            
            
            
            controller: VoiceController (
              noiseCount: 20,
             
              
              audioSrc: widget.message.content.toString(), // Ensure this is a valid audio source
              onComplete: () {
                // Handle completion
                log('Audio playback completed');
              },
              onPause: () {
                // Handle pause
                log('Audio playback paused');
              },
              onPlaying: () {
                // Handle playing
                log('Audio playback started');
              },
              onError: (err) {
                // Handle error
                log('Error occurred: $err');
              },
              maxDuration: const Duration(seconds: 300), // Set a valid max duration
              isFile: false, // Set to true if audioSrc is a file
            ),
            
            
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            SB.w(context.width*0.05),
            Text(
              Timegetter.formatTimestamp(widget.message.timestamp.toString()),
              style: TextStyle(
                  color: widget.isSender ? Colors.white70 : Colors.amber,
                  fontSize: 10),
            ),
            if (widget.isSender) ...[
              const SizedBox(width: 3),
              buildMessageStatus(widget.message),
            ],
          ],
        ),
      ],
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