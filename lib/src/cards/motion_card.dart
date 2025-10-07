
import 'package:flutter/material.dart';

class MotionCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enableAnimation;
  final Duration animationDuration;

  const MotionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.elevation = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.onTap,
    this.onLongPress,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<MotionCard> createState() => MotionCardState();
}

class MotionCardState extends State<MotionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTapDown(TapDownDetails details) {
    if (widget.enableAnimation) {
      controller.forward();
    }
  }

  void onTapUp(TapUpDetails details) {
    if (widget.enableAnimation) {
      controller.reverse();
    }
  }

  void onTapCancel() {
    if (widget.enableAnimation) {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null ? onTapDown : null,
      onTapUp: widget.onTap != null ? onTapUp : null,
      onTapCancel: widget.onTap != null ? onTapCancel : null,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.enableAnimation ? scaleAnimation.value : 1.0,
            child: child,
          );
        },
        child: Card(
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}