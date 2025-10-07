import 'package:flutter/material.dart';

class CircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? text;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  const CircleAvatar({
    Key? key,
    this.imageUrl,
    this.text,
    this.size = 40,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
    this.child,
    this.showBorder = false,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
          color: borderColor,
          width: borderWidth,
        )
            : null,
        image: imageUrl != null
            ? DecorationImage(
          image: NetworkImage(imageUrl!),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: child ??
          (text != null
              ? Center(
            child: Text(
              _getInitials(text!),
              style: TextStyle(
                color: textColor,
                fontSize: size * 0.35,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              : null),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
    } else {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
  }
}