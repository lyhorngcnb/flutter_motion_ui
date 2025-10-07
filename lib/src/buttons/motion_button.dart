import 'package:flutter/material.dart';

class MotionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final double elevation;

  const MotionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.elevation = 2.0,
  });

  @override
  MotionButtonState createState() => MotionButtonState();
}

class MotionButtonState extends State<MotionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = widget.backgroundColor ?? theme.primaryColor;
    final foregroundColor =
        widget.foregroundColor ?? theme.colorScheme.onPrimary;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: _isPressed ? 2 : widget.elevation,
              offset: Offset(0, _isPressed ? 1 : 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        child: DefaultTextStyle(
          style: TextStyle(
            color: foregroundColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
