import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Spacing {
  static Widget x(BuildContext context, double val) {
    return SizedBox(width: context.width * val);
  }

  static Widget y(BuildContext context, double val) {
    return SizedBox(height: context.height * val);
  }
}
