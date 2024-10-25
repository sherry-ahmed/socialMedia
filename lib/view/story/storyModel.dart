class Story {
  final String storyId; // Unique story ID based on timestamp
  final String userId; // User ID who posted the story
  final DateTime createdAt; // Timestamp for story creation
  final List<StoryChunk> chunks; // List of story chunks

  Story({
    required this.storyId,
    required this.userId,
    required this.createdAt,
    required this.chunks,
  });

  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
      'userId': userId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'chunks': chunks.map((chunk) => chunk.toMap()).toList(),
    };
  }
}

class StoryChunk {
  final String mediaUrl; // URL for image or video, or empty if text story
  final String caption; // Caption for the chunk, empty if none
  final String type; // Type of chunk: 'image', 'video', or 'text'

  StoryChunk({
    required this.mediaUrl,
    required this.caption,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'mediaUrl': mediaUrl,
      'caption': caption,
      'type': type,
    };
  }
}
