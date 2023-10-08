import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassContainer extends StatelessWidget {
  const FrostedGlassContainer(
      {super.key,
      this.padding,
      this.height,
      this.width,
      this.radius = 25,
      required this.child});
  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x14FFFFFF),
            Color(0x29FFFFFF),
          ],
          stops: [0.6506, 1.6974],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 24,
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
              padding: padding ?? const EdgeInsets.all(0.0), child: child),
        ),
      ),
    );
  }
}
