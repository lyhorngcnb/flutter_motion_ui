import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  final double size;
  final BadgePosition position;
  final bool showBadge;

  const Badge({
    Key? key,
    required this.child,
    this.text,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.size = 16,
    this.position = BadgePosition.topEnd,
    this.showBadge = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showBadge) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: position == BadgePosition.topEnd || position == BadgePosition.topStart
              ? -size / 4
              : null,
          bottom: position == BadgePosition.bottomEnd || position == BadgePosition.bottomStart
              ? -size / 4
              : null,
          right: position == BadgePosition.topEnd || position == BadgePosition.bottomEnd
              ? -size / 4
              : null,
          left: position == BadgePosition.topStart || position == BadgePosition.bottomStart
              ? -size / 4
              : null,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            child: text != null
                ? Center(
              child: Text(
                text!,
                style: TextStyle(
                  color: textColor,
                  fontSize: size * 0.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
}

enum BadgePosition {
  topEnd,
  topStart,
  bottomEnd,
  bottomStart,
}
