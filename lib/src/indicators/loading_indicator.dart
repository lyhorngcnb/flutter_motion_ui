import 'package:flutter/material.dart';
import 'dart:math' as math;

enum LoadingType { circular, dots, pulse, spinner }

/// Beautiful custom loading indicators
class LoadingIndicator extends StatefulWidget {
  final LoadingType type;
  final Color? color;
  final double size;

  const LoadingIndicator({
    super.key,
    this.type = LoadingType.circular,
    this.color,
    this.size = 40,
  });

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    switch (widget.type) {
      case LoadingType.circular:
        return _CircularLoader(
          controller: _controller,
          color: color,
          size: widget.size,
        );
      case LoadingType.dots:
        return _DotsLoader(
          controller: _controller,
          color: color,
          size: widget.size,
        );
      case LoadingType.pulse:
        return _PulseLoader(
          controller: _controller,
          color: color,
          size: widget.size,
        );
      case LoadingType.spinner:
        return _SpinnerLoader(
          controller: _controller,
          color: color,
          size: widget.size,
        );
    }
  }
}

class _CircularLoader extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double size;

  const _CircularLoader({
    required this.controller,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 3,
      ),
    );
  }
}

class _DotsLoader extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double size;

  const _DotsLoader({
    required this.controller,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 2,
      height: size / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final delay = index * 0.2;
              final value = (controller.value - delay) % 1.0;
              final scale = math.sin(value * math.pi) * 0.5 + 0.5;

              return Transform.scale(
                scale: scale,
                child: Container(
                  width: size / 4,
                  height: size / 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class _PulseLoader extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double size;

  const _PulseLoader({
    required this.controller,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final scale = (math.sin(controller.value * 2 * math.pi) + 1) / 2;

        return Transform.scale(
          scale: 0.7 + (scale * 0.3),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.7 + (scale * 0.3)),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

class _SpinnerLoader extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double size;

  const _SpinnerLoader({
    required this.controller,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2 * math.pi,
          child: CustomPaint(
            size: Size(size, size),
            painter: _SpinnerPainter(color: color),
          ),
        );
      },
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final Color color;

  _SpinnerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      math.pi * 1.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) => false;
}
