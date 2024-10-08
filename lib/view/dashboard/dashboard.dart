
import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/Flirts/view/flirt.dart';
import 'package:socialmedia/view/User/view/userList.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const Text('Home'),
      UserSwiper(),
      const Text('play'),
      UserListScreen(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBaritem() {
    return [
      PersistentBottomNavBarItem(
        title: 'Home',
        iconSize: 35,
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.white,
          inactiveIcon: const Icon(
            Icons.home,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          )),
      PersistentBottomNavBarItem(
        title: 'Flirts',
        iconSize: 35,
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.white,
        
          inactiveIcon: const Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.favorite,
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
        title: 'Friends',
        iconSize: 35,
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.white,
          inactiveIcon: const Icon(
            Icons.person,
            color: Colors.grey,
          ),
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          )),
      PersistentBottomNavBarItem(
        
        title: 'Profile',
        iconSize: 35,
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.white,
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
