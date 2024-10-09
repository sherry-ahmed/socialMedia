import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/Flirts/view/flirt.dart';
import 'package:socialmedia/view/User/view/userList.dart';
import 'package:socialmedia/view/home/view/home.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
       Home(),
      UserSwiper(),
      const Text('play'),
      UserListScreen(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBaritem(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
          title: 'Home',
          activeColorSecondary: Colors.white,
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
          iconSize: 25,
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: Colors.white54,
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
          iconSize: 25,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: Colors.white54,
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
          activeColorPrimary: Colors.white54,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      PersistentBottomNavBarItem(
          title: 'Friends',
          iconSize: 25,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: Colors.white54,
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
          iconSize: 25,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: Colors.white54,
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
            isVisible: true,
            handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,
        confineToSafeArea: true,
            context,
            screens: _buildScreen(),
            items: _navBaritem(context),
            controller: controller,
            backgroundColor: Colors.black,
            navBarStyle: NavBarStyle.style7,
            decoration: NavBarDecoration(
              //colorBehindNavBar: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 8),
                  blurRadius: 12,
                  spreadRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            animationSettings: const NavBarAnimationSettings(
                navBarItemAnimation: ItemAnimationSettings(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn),
                    screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
            ),
            )
          ),
        ));
  }
}
