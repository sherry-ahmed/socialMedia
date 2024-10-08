import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Blockreport extends StatelessWidget {
  const Blockreport({
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
          value: 'Report',
          child: Row(
            children: [
              Icon(Icons.block, color: Colors.black,),
              Text('Report'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Block',
          child: Row(
            children: [
              Icon(Icons.report, color: Colors.red,),
              Text('Block'),
              Divider(height: 5,)
            ],
          ),
        ),
        
      ],
    );
  }
}