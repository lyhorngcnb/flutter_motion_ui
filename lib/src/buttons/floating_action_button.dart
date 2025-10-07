import 'package:flutter/material.dart';

class MotionFloatingActionButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color hoverColor;
  final Color splashColor;
  final double elevation;
  final Duration animationDuration;
  final Curve animationCurve;

  const MotionFloatingActionButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.hoverColor = Colors.blueAccent,
    this.splashColor = Colors.blue,
    this.elevation = 6.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  _MotionFloatingActionButtonState createState() =>
      _MotionFloatingActionButtonState();
}

class _MotionFloatingActionButtonState
    extends State<MotionFloatingActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hover) {
    setState(() => _isHovered = hover);
    if (hover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: widget.onPressed,
          backgroundColor: _isHovered ? widget.hoverColor : widget.backgroundColor,
          elevation: _isHovered ? widget.elevation + 2 : widget.elevation,
          child: widget.child,
        ),
      ),
    );
  }
}