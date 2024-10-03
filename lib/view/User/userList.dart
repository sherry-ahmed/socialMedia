import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/imports.dart';
import 'package:socialmedia/view/User/controller.dart/userListController.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({super.key});

  final DatabaseReference userRef = FirebaseDatabase.instance.ref('Users');
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: GetBuilder<Userlistcontroller>(
        init: Userlistcontroller(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Animated Container for the search bar
              AnimatedContainer(
                curve: Curves.easeIn,
                height: controller.showsearchbar
                    ? 60
                    : 0, // Height changes smoothly
                duration:
                    const Duration(milliseconds: 500), // Smooth transition time
                child: controller.showsearchbar
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Searchbar(searchController: searchController),
                      )
                    : const SizedBox(), // Empty container when search bar is hidden
              ),
              // AppBar Row with Search and Menu Icon
              !controller.showsearchbar
                  ? SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          SB.w(12),
                          Text(
                            'Friends',
                            style: Theme.of(context).appBarTheme.titleTextStyle,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.searchbar(true); // Open search bar
                                },
                                icon: const Icon(Icons.search),
                              ),
                              const PopMenuitem(),
                            ],
                          )
                        ],
                      ),
                    )
                  : const SizedBox(), // Empty when search bar is visible
              SB.h(30),

              // Firebase Animated List
              Expanded(
                child: FirebaseAnimatedList(
                  query: userRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    if (Sessioncontroller.userid.toString() ==
                        snapshot.child('uid').value.toString()) {
                      return const SizedBox();
                    } else {
                      final username =
                          snapshot.child('username').value.toString();
                      if (searchController.text.isEmpty) {
                        return Card(
                          elevation: 10,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Profile Image
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: snapshot
                                              .child('profile')
                                              .value
                                              .toString()
                                              .isEmpty
                                          ? AssetImage(Assets.images.user.path)
                                              as ImageProvider
                                          : NetworkImage(snapshot
                                              .child('profile')
                                              .value
                                              .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SB.w(20),
                                // User Info
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot
                                          .child('username')
                                          .value
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      snapshot.child('email').value.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (username
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Card(
                          elevation: 10,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Profile Image
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: snapshot
                                              .child('profile')
                                              .value
                                              .toString()
                                              .isEmpty
                                          ? AssetImage(Assets.images.user.path)
                                              as ImageProvider
                                          : NetworkImage(snapshot
                                              .child('profile')
                                              .value
                                              .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SB.w(20),
                                // User Info
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot
                                          .child('username')
                                          .value
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      snapshot.child('email').value.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Searchbar extends StatelessWidget {
   Searchbar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;
  final controller = Get.find<Userlistcontroller>();
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      maxLines: 1,
      controller: searchController,
      cursorColor: Colors.black,
      onChanged: (value) {
        controller.rebuild();
      },
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 14, horizontal: 12),
        fillColor: Colors.white,
        hintText: 'search',
        filled: true,
        hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: IconButton(
          onPressed: () {
            controller.searchbar(false); // Close search bar
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}

class PopMenuitem extends StatelessWidget {
  const PopMenuitem({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert), // Three dots icon
      onSelected: (String value) {
        log('Selected: $value');
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Option 1',
          child: Text('Friends'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 2',
          child: Text('Setting'),
        ),
        const PopupMenuItem<String>(
          value: 'Option 3',
          child: Text('Profile'),
        ),
      ],
    );
  }
}
