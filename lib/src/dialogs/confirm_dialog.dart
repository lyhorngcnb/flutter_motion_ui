import 'package:flutter/material.dart';

import '../../flutter_motion_ui.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final Color confirmColor;
  final Color cancelColor;
  final Color backgroundColor;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    required this.onCancel,
    this.confirmColor = Colors.blue,
    this.cancelColor = Colors.grey,
    this.backgroundColor = Colors.white,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = Colors.blue,
    Color cancelColor = Colors.grey,
    Color backgroundColor = Colors.white,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
        confirmColor: confirmColor,
        cancelColor: cancelColor,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MotionDialog(
      title: title,
      content: content,
      backgroundColor: backgroundColor,
      actions: [
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            foregroundColor: cancelColor,
          ),
          child: Text(cancelText),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}