import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.height = 56,
    this.actions,
    this.isGradientTitle = false,
  });
  final String title;
  final VoidCallback? onBackPressed;
  final double height;
  final List<Widget>? actions;
  final bool isGradientTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: onBackPressed ??
            () {
              Get.back();
            },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
