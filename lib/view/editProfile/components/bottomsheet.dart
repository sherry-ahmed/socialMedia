import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;

  const ImageSourceBottomSheet({required this.onImageSourceSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Get.back(closeOverlays: true); // Close the bottom sheet
              onImageSourceSelected(ImageSource.camera); // Trigger the callback
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Get.back(closeOverlays: true); // Close the bottom sheet
              onImageSourceSelected(ImageSource.gallery); // Trigger the callback
            },
          ),
        ],
      ),
    );
  }
}

// Example usage of the bottom sheet in your screen


