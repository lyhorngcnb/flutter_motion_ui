import 'package:flutter/material.dart';

class FilterChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;
  final Widget? icon;
  final Duration animationDuration;
  final Curve animationCurve;

  const FilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.backgroundColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.textColor = Colors.black87,
    this.selectedTextColor = Colors.white,
    this.icon,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  FilterChipState createState() => FilterChipState();
}

class FilterChipState extends State<FilterChip> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.selected
                ? widget.selectedColor
                : _isHovered
                ? widget.backgroundColor.withAlpha((0.8 * 255).toInt())
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.selected
                  ? widget.selectedColor
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.selected
                      ? widget.selectedTextColor
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
