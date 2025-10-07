import 'package:flutter/material.dart';

class MotionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color titleColor;
  final double elevation;
  final bool centerTitle;
  final Widget? leading;
  final double height;

  const MotionAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black87,
    this.elevation = 4,
    this.centerTitle = true,
    this.leading,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor.withAlpha((0.9 * 255).toInt()),
              backgroundColor.withAlpha((0.7 * 255).toInt()),
            ],
          ),
        ),
      ),
    );
  }
}