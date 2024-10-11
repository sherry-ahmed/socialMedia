import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class Imagecomponent extends StatelessWidget {
  final String profile;
  final double height;
  final double width;

  const Imagecomponent({super.key, required this.profile, required this.height, required this.width});

 

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
          imageUrl: profile,
          placeholder: (context, url) =>
               Imagecomponentshimmer(width: width, height: height), // Placeholder while loading
          errorWidget: (context, url, error) =>
              const Icon(Icons.error), // Error icon if the image fails to load
          fit: BoxFit.cover, // Ensures the image covers the container properly
        
      
    );
  }
}


class Imagecomponentshimmer extends StatelessWidget {
  final double width;
  final double height;

  const Imagecomponentshimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: width,
        width: height,
        
      ),
    );
  }
}