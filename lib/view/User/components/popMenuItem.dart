import 'package:flutter/material.dart';
import 'package:socialmedia/components/imports.dart';

class PopMenuitem extends StatelessWidget {
  const PopMenuitem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert), // Three dots icon
      onSelected: (String value) {
        // Handle menu item click here
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