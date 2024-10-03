import 'package:flutter/material.dart';

class Profilecolumn extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onImagePressed;
  

  const Profilecolumn({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onImagePressed,
            child: Image.asset(
              imagePath,
              width: 45,
              height: 45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
