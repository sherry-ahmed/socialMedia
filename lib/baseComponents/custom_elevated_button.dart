import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  Color? textColor;

  double? width;
  double? height;
  Color? shadowColor;
  double? elevation;
  Color? color;
  double? radius;
  final bool loading;

  CustomElevatedButton({
    super.key,
    required this.loading,
    required this.text,
    this.textColor,
    required this.onPressed,
    this.width,
    this.height,
    this.shadowColor,
    this.elevation,
    this.color,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shadowColor: shadowColor,
        elevation: elevation,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.white,
        disabledForegroundColor: Colors.black,
        minimumSize: Size(width ?? context.width, height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
      ),
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : Text(
              text,
              style: TextStyle(fontSize: 16.0, color: textColor),
            ),
    );
  }
}
