import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/appLifeCycle.dart';

class UserStatusChatroom extends StatelessWidget {
  UserModel? user;

  UserStatusChatroom(this.user, {super.key});
  final appLifecycleController = Get.find<AppLifecycleController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
  stream: appLifecycleController.getTypingStatus(user!.uid.toString()),
  builder: (context, snapshot) {
    // Determine if the widget should be visible
    bool isVisible = snapshot.hasData && snapshot.data! == true;

    return AnimatedCrossFade(
      firstChild: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user!.username,
            style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(height: 1),
          ),
          Text(
            "Typing...",
            style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(fontSize: 9, color: Colors.amber),
          ),
        ],
      ),
      secondChild: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user!.username,
              style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(height: 1),
            ),
          ],
        ),
      ),
      crossFadeState: isVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500), // Duration of the animation
    );
  },
);



  }
}
