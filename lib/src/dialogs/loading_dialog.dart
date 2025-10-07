
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final Color spinnerColor;

  const LoadingDialog({
    super.key,
    this.message = 'Loading...',
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.spinnerColor = Colors.blue,
  });

  static void show({
    required BuildContext context,
    String message = 'Loading...',
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black87,
    Color spinnerColor = Colors.blue,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
        spinnerColor: spinnerColor,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}