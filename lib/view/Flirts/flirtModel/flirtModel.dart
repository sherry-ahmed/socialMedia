class User {
  String? age;
  String? bio;
  String? city;
  String? country;
  List<dynamic>? dateOfBirth;
  String? email;
  String? fbLink;
  List<dynamic>? friends;
  String? gender;
  List<dynamic>? hobbies;
  String? instaLink;
  String? isOnline;
  String? personalityType;
  String? phone;
  String? profile;
  String? relationshipType;
  String? sexualOrientation;
  String? state;
  String? tiktokLink;
  String? uid;
  String? username;

  User({
    this.age,
    this.bio,
    this.city,
    this.country,
    this.dateOfBirth,
    this.email,
    this.fbLink,
    this.friends,
    this.gender,
    this.hobbies,
    this.instaLink,
    this.isOnline,
    this.personalityType,
    this.phone,
    this.profile,
    this.relationshipType,
    this.sexualOrientation,
    this.state,
    this.tiktokLink,
    this.uid,
    this.username,
  });

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
      age: data['age'],
      bio: data['bio'],
      city: data['city'],
      country: data['country'],
      dateOfBirth: data['dateOfBirth'],
      email: data['email'],
      fbLink: data['fbLink'],
      friends: List<String>.from(data['friends'] ?? []),
      gender: data['gender'],
      hobbies: List<String>.from(data['hobbies'] ?? []),
      instaLink: data['instaLink'],
      isOnline: data['isOnline'],
      personalityType: data['personalityType'],
      phone: data['phone'],
      profile: data['profile'],
      relationshipType: data['relationshipType'],
      sexualOrientation: data['sexualOrientation'],
      state: data['state'],
      tiktokLink: data['tiktokLink'],
      uid: data['uid'],
      username: data['username'],
    );
  }
}
