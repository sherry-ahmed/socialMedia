import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/checkedInView/view/checkedinView.dart';

class Mapviewpopup extends StatelessWidget {
  const Mapviewpopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
        PopupMenuButton<String>(
          color: Colors.white,
          icon: const Icon(Icons.more_vert),
          onSelected: (String value) {
            log('Selected: $value');
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Your Locations',
              onTap: () {
                Get.to(() => Checkedinview(userid: Sessioncontroller.userid));

              },
              child: const Text('Your Locations'),
            ),
          ],
       
    );
  }
}
