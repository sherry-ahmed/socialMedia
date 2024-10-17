import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/home/view/friendRequests.dart';

class HomePopupMenu extends StatelessWidget {
  const HomePopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopupMenuButton<String>(
          color: Colors.white,
          icon: const Icon(Icons.more_vert),
          onSelected: (String value) {
            log('Selected: $value');
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Requests',
              onTap: () {
                Get.to(() => Friendrequests(
                    currentUserUID: Sessioncontroller.userid.toString()));
              },
              child: const Text('Requests'),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('FriendSystem')
              .doc(Sessioncontroller.userid.toString())
              .collection('requests')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return const Positioned(
                top: 8,
                right: 10,
                child: Icon(Icons.circle, color: Colors.red, size: 12),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
