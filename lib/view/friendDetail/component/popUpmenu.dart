import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class FriendDetailPopupMenu extends StatelessWidget {
  const FriendDetailPopupMenu({
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
        PopupMenuItem<String>(
          value: 'Edit',
          onTap: () {},
          child: const Text('Edit'),
        ),
        PopupMenuItem<String>(
          value: 'Share',
          onTap: () {},
          child: const Text('Share'),
        ),
        PopupMenuItem<String>(
          value: 'View Address',
          onTap: () {},
          child: const Text('View Address'),
        ),
      ],
    );
  }
}
