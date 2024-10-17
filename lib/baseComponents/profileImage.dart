
import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';




class profileImage extends StatelessWidget {
  final String profile;
  final double height;
  final double width;

  profileImage(
      {super.key,
      required this.profile,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.amber),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        // Ensures the image inside is clipped to a circular shape
        child: CachedNetworkImage(
          imageUrl: profile,
          placeholder: (context, url) => profileImageshimmer(
              width: width, height: height), // Placeholder while loading
          errorWidget: (context, url, error) =>
              const Icon(Icons.error), // Error icon if the image fails to load
          fit: BoxFit.cover, // Ensures the image covers the container properly
        ),
      ),
    );
  }
}
