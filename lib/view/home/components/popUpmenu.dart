import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/home/view/friendRequests.dart';

class HomePopupMenu extends StatelessWidget {
  const HomePopupMenu({
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
          value: 'Requests',
          onTap: () {
            //Future.delayed(const Duration(seconds: 2));
            Get.to(()=>  Friendrequests(currentUserUID: Sessioncontroller.userid.toString()));
          },
          
          child: const Text('Requests'),
        ),
        
      ],
    );
  }
}