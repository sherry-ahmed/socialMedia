import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';


class profileImageshimmer extends StatelessWidget {
  final double width;
  final double height;

  const profileImageshimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}