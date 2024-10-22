import 'package:cloud_firestore/cloud_firestore.dart';

class CheckedInLocation {
  String userId;
  String storyline;
  String imageUrl;
  String address;
  String placeName;
  double latitude;
  double longitude;
  String eventId; // This will be a timestamp in microseconds.

  CheckedInLocation({
    required this.userId,
    required this.storyline,
    required this.imageUrl,
    required this.address,
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.eventId,
  });

  // Convert a CheckedInLocation object into a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'storyline': storyline,
      'imageUrl': imageUrl,
      'address': address,
      'placeName': placeName,
      'latitude': latitude,
      'longitude': longitude,
      'eventId': eventId,
    };
  }

  // Create a CheckedInLocation object from a Firestore document
  factory CheckedInLocation.fromDocument(DocumentSnapshot doc) {
    return CheckedInLocation(
      userId: doc['userId'],
      storyline: doc['storyline'],
      imageUrl: doc['imageUrl'],
      address: doc['address'],
      placeName: doc['placeName'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      eventId: doc['eventId'],
    );
  }
}
