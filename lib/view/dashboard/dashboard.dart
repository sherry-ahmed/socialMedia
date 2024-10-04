
import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/User/view/userList.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  // void _logout(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut(); // Sign out from Firebase
  //     // Navigate to sign-up/login page after successful logout
  //     Sessioncontroller.userid = '';
  //     Get.off(() => LoginScreen());
  //   } catch (e) {
  //     // Handle any errors here (e.g., show a Snackbar)
  //     Get.snackbar('Error', 'Error Logging out: $e');
  //   }
  // }
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const Text('Home'),
      const Text('edit'),
      const Text('play'),
      UserListScreen(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBaritem() {
    return [
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(
            Icons.home,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(
            Icons.message,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.message,
            color: Colors.white,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
          activeColorPrimary: Colors.white,
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: const Icon(
            Icons.dashboard,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.dashboard,
            color: Colors.white,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          Get.back();
        },
        child: SafeArea(
          child: PersistentTabView(
            context,
            screens: _buildScreen(),
            items: _navBaritem(),
            controller: controller,
            backgroundColor: Colors.black,
            navBarStyle: NavBarStyle.style15,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ));
  }
}
