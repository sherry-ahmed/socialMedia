import 'package:flutter/material.dart';

class SB extends StatelessWidget {
  final Widget _child;

  SB.h(double height, {super.key}) : _child = _WH(h: height);

  SB.w(double width, {super.key}) : _child = _WH(w: width);

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}

class _WH extends StatelessWidget {
  final double? h, w;

  const _WH({this.h, this.w});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h, width: w);
  }
}
