import 'package:flutter/material.dart';

class MotionDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;
  final Color backgroundColor;
  final Color titleColor;
  final Color contentColor;
  final BorderRadiusGeometry borderRadius;

  const MotionDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black87,
    this.contentColor = Colors.black54,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) : super(key: key);

  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
    Color backgroundColor = Colors.white,
    Color titleColor = Colors.black87,
    Color contentColor = Colors.black54,
  }) {
    showDialog(
      context: context,
      builder: (context) => MotionDialog(
        title: title,
        content: content,
        actions: actions,
        backgroundColor: backgroundColor,
        titleColor: titleColor,
        contentColor: contentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 16),
            // Content
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: contentColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}
