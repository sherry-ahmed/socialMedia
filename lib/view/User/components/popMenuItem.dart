import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class PopMenuitem extends StatelessWidget {
  const PopMenuitem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert),
      onSelected: (String value) {
        log('Selected: $value');
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Friends',
          child: Text('Friends'),
        ),
        const PopupMenuItem<String>(
          value: 'Settings',
          child: Text('Setting'),
        ),
        const PopupMenuItem<String>(
          value: 'Profile',
          child: Text('Profile'),
        ),
      ],
    );
  }
}