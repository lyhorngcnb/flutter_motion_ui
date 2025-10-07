import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final StatusBadgeType type;
  final Color? color;
  final TextStyle? textStyle;

  const StatusBadge({
    Key? key,
    required this.text,
    this.type = StatusBadgeType.info,
    this.color,
    this.textStyle,
  }) : super(key: key);

  Color _getBackgroundColor(BuildContext context) {
    if (color != null) return color!;

    switch (type) {
      case StatusBadgeType.success:
        return Colors.green;
      case StatusBadgeType.error:
        return Colors.red;
      case StatusBadgeType.warning:
        return Colors.orange;
      case StatusBadgeType.info:
        return Colors.blue;
      case StatusBadgeType.neutral:
        return Colors.grey;
    }
  }

  Color _getTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor(context);
    final textColor = _getTextColor(backgroundColor);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: textStyle ?? TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum StatusBadgeType {
  success,
  error,
  warning,
  info,
  neutral,
}
