import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/appLifeCycle.dart';

class UserStatus extends StatelessWidget {
  UserModel? user;

  UserStatus(this.user, {super.key});
  final appLifecycleController = Get.find<AppLifecycleController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: appLifecycleController.getOnlineStatus(user!.uid.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data! == true) {
          return const Icon(
            Icons.circle,
            color: Colors.amber,
            size: 15,
          );
        } else {
          return const SizedBox(); // No unread messages
        }
      },
    );
  }
}
