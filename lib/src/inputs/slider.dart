import 'package:flutter/material.dart';

class MotionSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangeEnd;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final bool showValue;
  final String? label;

  const MotionSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.onChangeEnd,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.white,
    this.showValue = true,
    this.label,
  });

  @override
  MotionSliderState createState() => MotionSliderState();
}

class MotionSliderState extends State<MotionSlider> {
  double _currentValue = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(MotionSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isDragging && widget.value != _currentValue) {
      _currentValue = widget.value;
    }
  }

  void _onChanged(double value) {
    setState(() => _currentValue = value);
    widget.onChanged(value);
  }

  void _onDragStart(_) {
    setState(() => _isDragging = true);
  }

  void _onDragEnd(_) {
    setState(() => _isDragging = false);
    widget.onChangeEnd?.call(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Stack(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: widget.activeColor,
                inactiveTrackColor: widget.inactiveColor,
                trackHeight: 4,
                thumbColor: widget.thumbColor,
                thumbShape: _CustomThumbShape(
                  isDragging: _isDragging,
                ),
                overlayColor: widget.activeColor.withAlpha((0.1 * 255).toInt()),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              ),
              child: Slider(
                value: _currentValue,
                min: widget.min,
                max: widget.max,
                onChanged: _onChanged,
                onChangeStart: _onDragStart,
                onChangeEnd: _onDragEnd,
              ),
            ),
            if (widget.showValue)
              Positioned(
                right: 0,
                top: -8,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.activeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _currentValue.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final bool isDragging;

  const _CustomThumbShape({required this.isDragging});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(20, 20);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;
    final fillPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = isDragging ? 3 : 2;

    canvas.drawCircle(center, isDragging ? 12 : 10, fillPaint);
    canvas.drawCircle(center, isDragging ? 12 : 10, borderPaint);
  }
}
