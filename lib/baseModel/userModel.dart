class UserModel {
  final String uid;
  final String email;
  final String username;
  final String profile;
  final String isOnline;
  final String? phone;
  final String? bio;
  final String? country;
  final String? state;
  final String? city;
  final List<String>? hobbies;
  final List<String>? requests;
  final List<String>? friends;
  final int? age;
  final String? instaLink;
  final String? fbLink;
  final String? tiktokLink;
  final String? gender;
  final String? sexualOrientation;
  final String? relationshipType;
  final String? personalityType;
  final List<int>? dateOfBirth;

  UserModel(
      {required this.uid,
      required this.email,
      required this.username,
      required this.profile,
      required this.isOnline,
      this.requests,
      this.friends,
      this.phone,
      this.bio,
      this.country,
      this.state,
      this.city,
      this.hobbies,
      this.age,
      this.instaLink,
      this.fbLink,
      this.tiktokLink,
      this.gender,
      this.personalityType,
      this.dateOfBirth,
      this.relationshipType,
      this.sexualOrientation});

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? profile,
    String? isOnline,
    String? phone,
    String? bio,
    String? country,
    String? state,
    String? city,
    List<String>? hobbies,
    List<String>? requests,
    List<String>? friends,
    int? age,
    String? instaLink,
    String? fbLink,
    String? tiktokLink,
    String? gender,
    String? sexualOrientation,
    String? relationshipType,
    String? personalityType,
    List<int>? dateOfBirth,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        username: username ?? this.username,
        profile: profile ?? this.profile,
        isOnline: isOnline ?? this.isOnline,
        phone: phone ?? this.phone,
        bio: bio ?? this.bio,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        hobbies: hobbies ?? this.hobbies,
        requests: requests?? this.requests,
        friends: friends?? this.friends,
        age: age ?? this.age,
        instaLink: instaLink ?? this.instaLink,
        fbLink: fbLink ?? this.fbLink,
        tiktokLink: tiktokLink ?? this.tiktokLink,
        gender: gender ?? this.gender,
        sexualOrientation: sexualOrientation ?? this.sexualOrientation,
        personalityType: personalityType ?? this.personalityType,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        relationshipType: relationshipType ?? this.relationshipType);
  }

  // Method to create a UserModel from a map (Firebase data)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      profile: map['profile'] ?? '',
      isOnline: map['isOnline'] ?? 'false',
      phone: map['phone'],
      bio: map['bio'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      hobbies: map['hobbies'] != null ? List<String>.from(map['hobbies']) : [],
      requests: map['requests'] != null ? List<String>.from(map['requests']) : [],
      friends: map['friends'] != null ? List<String>.from(map['friends']) : [],
      age: map['age'],
      instaLink: map['instaLink'],
      fbLink: map['fbLink'],
      tiktokLink: map['tiktokLink'],
      gender: map['gender'],
      relationshipType: map['relationshipType'],
      personalityType: map['personalityType'],
      sexualOrientation: map['sexualOrientation'],
      dateOfBirth:
          map['dateOfBirth'] != null ? List<int>.from(map['dateOfBirth']) : [],
    );
  }
    // Static method to create a list of UserModel from a list of maps
  static List<UserModel> fromMapList(List<Map<String, dynamic>> list) {
    return list.map((map) => UserModel.fromMap(map)).toList();
  }

  // Method to convert UserModel to a map (for saving to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profile': profile,
      'isOnline': isOnline,
      'phone': phone,
      'bio': bio,
      'country': country,
      'state': state,
      'city': city,
      'hobbies': hobbies,
      'requests': requests,
      'friends': friends,
      'age': age,
      'instaLink': instaLink,
      'fbLink': fbLink,
      'tiktokLink': tiktokLink,
      'gender': gender,
      'relationshipType': relationshipType,
      'personalityType': personalityType,
      'sexualOrientation': sexualOrientation,
      'dateOfBirth': dateOfBirth
    };
  }
}
