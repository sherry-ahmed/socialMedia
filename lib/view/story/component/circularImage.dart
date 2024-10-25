import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:socialmedia/services/imports.dart';

class CircularNetworkImage extends StatelessWidget {
  final String imageUrl;

  CircularNetworkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
           
            DottedBorder(
              strokeCap: StrokeCap.round,
              stackFit: StackFit.loose,
              borderType: BorderType.Circle,
              color: Colors.amber, // Dotted border color
              strokeWidth: 2.0, // Border width
              dashPattern: [15, 3], // Dash pattern for dotted border
              child: CircleAvatar(
                radius: 30, // Half of the desired width/height for the circular avatar
                backgroundColor: Colors.grey[300], // Background color while loading
                backgroundImage: NetworkImage(imageUrl),
                // You can use Image.network instead of NetworkImage if you prefer
              ),
            ),
             Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,child: Icon(Icons.add, color: Colors.amber,size: 18,))),
          ],
          
        ),
        SB.w(20),
        Text('Add Story...', style: TextStyle(color: Colors.amber.withOpacity(0.8), fontSize: 20),)
      ],
    );
  }
}
