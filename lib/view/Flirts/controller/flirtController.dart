import 'package:socialmedia/baseComponents/imports.dart';

class Flirtcontroller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  RxList<UserModel> userList =
      <UserModel>[].obs; // Observable list to hold UserModel instances

  // Fetch all users from Firebase
  Future<void> fetchAllUsers() async {
    try {
      DataSnapshot snapshot = await ref.child("Users").get();
      if (snapshot.exists) {
        // Clear existing userList before adding new users
        userList.clear();

        // Ensure we are working with a Map
        Map<Object?, Object?> usersData =
            snapshot.value as Map<Object?, Object?>;

        // Convert each user data into UserModel and add to the userList
        usersData.forEach((key, value) {
          if (value is Map<Object?, Object?>) {
            // Convert to UserModel
            Map<String, dynamic> userData =
                value.map((k, v) => MapEntry(k.toString(), v));

            // Create a new UserModel instance for each user
            UserModel newUser = UserModel.fromMap(userData);
            userList.add(newUser); // Add the new user instance to userList

            log(newUser.uid.toString()); // Log UID for verification
          }
        });
      } else {
        log("No users found.");
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }
}




//  Future<void> getColor() async {
//                             Future.delayed(Duration(seconds: 2));
//                             dominantColor = await flirtcontroller
//                                 .extractDominantColor(user.profile);
//                             // Update UI with the new color
//                           }



// Future<Color?> extractDominantColor(String imageUrl) async {
//     try {
//       // Use PaletteGenerator to extract colors from the image
//       final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
//         NetworkImage(imageUrl),
//       );

//       // Return the dominant color if available
//       return paletteGenerator.dominantColor?.color;
//     } catch (e) {
//       print("Error extracting color: $e");
//       return null; // Return null if there's an error
//     }
//   }