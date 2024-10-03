import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool shadowColor;
  final bool elevation;
  final Color color;
  final int radius;
  final bool loading;

  const CustomElevatedButton({
    super.key,
    required this.loading,
    required this.text,
    required this.textColor,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.shadowColor,
    required this.elevation,
    required this.color,
    required this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shadowColor: shadowColor ? Colors.black87 : null,
        elevation: elevation ? 10 : null,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.white,
        disabledForegroundColor: Colors.black,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.toDouble()),
        ),
      ),
      child: loading? const Center(child: CircularProgressIndicator(color: Colors.black,)): Text(
        text,
        style: TextStyle(fontSize: 16.0, color: textColor),
      ),
    );
  }
}
