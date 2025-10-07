import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double blur;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.blur = 10.0,
    this.borderRadius = 20.0,
    this.baseColor = const Color(0x10FFFFFF),
    this.highlightColor = const Color(0x20FFFFFF),
    this.borderWidth = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: baseColor,
          border: Border.all(
            color: highlightColor,
            width: borderWidth,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: createBlur(blur),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  ImageFilter createBlur(double blur) {
    return ImageFilter.blur(sigmaX: blur, sigmaY: blur);
  }
}