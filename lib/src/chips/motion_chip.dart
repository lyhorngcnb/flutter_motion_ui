import 'package:flutter/material.dart';

class MotionChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;
  final Widget? avatar;
  final Widget? deleteIcon;
  final VoidCallback? onDeleted;
  final Duration animationDuration;
  final Curve animationCurve;

  const MotionChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.backgroundColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.textColor = Colors.black87,
    this.selectedTextColor = Colors.white,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  MotionChipState createState() => MotionChipState();
}

class MotionChipState extends State<MotionChip> {
  bool _isHovered = false;

  void _onTap() {
    widget.onSelected?.call(!widget.selected);
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.selected
                ? widget.selectedColor
                : _isHovered
                ? widget.backgroundColor.withAlpha((0.8 * 255).toInt())
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: widget.selected
                ? Border.all(color: widget.selectedColor)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.avatar != null) ...[
                widget.avatar!,
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
              if (widget.onDeleted != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: widget.onDeleted,
                  child: widget.deleteIcon ?? const Icon(Icons.close, size: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
