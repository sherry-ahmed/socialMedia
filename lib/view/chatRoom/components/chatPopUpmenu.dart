import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Chatpopupmenu extends StatelessWidget {
  const Chatpopupmenu({
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
          value: 'Search',
          onTap: () {},
          child: const Text('Search'),
        ),
        PopupMenuItem<String>(
          value: 'MuteNotification',
          onTap: () {},
          child: const Text('MuteNotification'),
        ),
          PopupMenuItem<String>(
          value: 'Wallpaper',
          onTap: () {},
          child: const Text('Wallpaper'),
        ),
        PopupMenuItem<String>(
          value: 'Clear Chat',
          onTap: () {},
          child: const Text('Clear Chat'),
        ),
        PopupMenuItem<String>(
          value: 'Export chat',
          onTap: () {},
          child: const Text('Export Chat'),
        ),
      ],
    );
  }
}
