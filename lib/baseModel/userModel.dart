class UserModel {
  final String uid;
  final String email;
  final String username;
  final String profile;
  final String isOnline;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.profile,
    required this.isOnline,
  });
    UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? profile,
    String? isOnline,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profile: profile ?? this.profile,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  // Method to create a UserModel from a map (Firebase data)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      profile: map['profile'] ?? '',
      isOnline: map['isOnline'] ?? 'false',
    );
  }

  // Method to convert UserModel to a map (for saving to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profile': profile,
      'isOnline': isOnline,
    };
  }
}
