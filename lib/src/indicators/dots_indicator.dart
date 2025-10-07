import 'package:flutter/material.dart';

class DotsIndicator extends StatefulWidget {
  final int dotsCount;
  final int currentDot;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double activeDotSize;
  final Duration animationDuration;
  final Curve animationCurve;

  const DotsIndicator({
    Key? key,
    required this.dotsCount,
    required this.currentDot,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.dotSize = 8.0,
    this.activeDotSize = 12.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  _DotsIndicatorState createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.dotsCount, (index) {
        final isActive = index == widget.currentDot;
        return AnimatedContainer(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? widget.activeDotSize : widget.dotSize,
          height: isActive ? widget.activeDotSize : widget.dotSize,
          decoration: BoxDecoration(
            color: isActive ? widget.activeColor : widget.inactiveColor,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
