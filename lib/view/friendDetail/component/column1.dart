import 'package:flutter/material.dart';

class Column1 extends StatelessWidget {
  final Widget icon;
  final String text;
  const Column1({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white54),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [icon, Text(text)],
          ),
        ),
      ),
    );
  }
}