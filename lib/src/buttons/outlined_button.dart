import 'package:flutter/material.dart';

class MotionOutlinedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color hoverColor;
  final Color textColor;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const MotionOutlinedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderColor = Colors.blue,
    this.hoverColor = Colors.blue,
    this.textColor = Colors.blue,
    this.borderWidth = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  MotionOutlinedButtonState createState() => MotionOutlinedButtonState();
}

class MotionOutlinedButtonState extends State<MotionOutlinedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHovered ? widget.hoverColor : widget.borderColor,
            width: widget.borderWidth,
          ),
          borderRadius: widget.borderRadius,
          color: _isHovered
              ? widget.hoverColor.withAlpha((0.1 * 255).toInt()) // 10% opacity
              : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: widget.borderRadius,
            hoverColor: widget.hoverColor.withAlpha((0.2 * 255).toInt()), // 20%
            splashColor: widget.hoverColor.withAlpha((0.3 * 255).toInt()), // 30%
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: _isHovered
                      ? widget.hoverColor
                      : widget.textColor,
                  fontWeight: FontWeight.w600,
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}