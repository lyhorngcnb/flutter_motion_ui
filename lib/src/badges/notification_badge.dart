import 'package:flutter/material.dart';

import '../../flutter_motion_ui.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final double maxCount;
  final BadgePosition position;

  const NotificationBadge({
    super.key,
    required this.count,
    this.size = 20,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.maxCount = 99,
    this.position = BadgePosition.topEnd,
  });

  String get _displayText {
    if (count <= 0) return '';
    if (count > maxCount) return '$maxCount+';
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _displayText,
          style: TextStyle(
            color: textColor,
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
