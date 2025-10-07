import 'package:flutter/material.dart';

class ChoiceChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;
  final Widget? avatar;
  final Duration animationDuration;
  final Curve animationCurve;

  const ChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.backgroundColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.textColor = Colors.black87,
    this.selectedTextColor = Colors.white,
    this.avatar,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  ChoiceChipState createState() => ChoiceChipState();
}

class ChoiceChipState extends State<ChoiceChip> {
  bool _isHovered = false;

  void _onTap() {
    widget.onSelected(!widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.selected
                ? widget.selectedColor.withAlpha((0.1 * 255) .toInt())
                : _isHovered
                ? widget.backgroundColor.withAlpha((0.1 * 255).toInt())
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.selected
                  ? widget.selectedColor
                  : _isHovered
                  ? widget.backgroundColor
                  : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.avatar != null) ...[
                widget.avatar!,
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.selected
                      ? widget.selectedColor
                      : widget.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
