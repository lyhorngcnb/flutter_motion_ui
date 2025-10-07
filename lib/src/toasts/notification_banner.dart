import 'package:flutter/material.dart';

class NotificationBanner extends StatefulWidget {
  final String title;
  final String message;
  final NotificationBannerType type;
  final VoidCallback? onClose;
  final Duration duration;
  final bool showCloseButton;

  const NotificationBanner({
    Key? key,
    required this.title,
    required this.message,
    this.type = NotificationBannerType.info,
    this.onClose,
    this.duration = const Duration(seconds: 5),
    this.showCloseButton = true,
  }) : super(key: key);

  @override
  _NotificationBannerState createState() => _NotificationBannerState();
}

enum NotificationBannerType {
  success,
  error,
  warning,
  info,
}

class _NotificationBannerState extends State<NotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    // Auto dismiss after duration
    if (widget.duration != Duration.zero) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      if (mounted && widget.onClose != null) {
        widget.onClose!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case NotificationBannerType.success:
        return Colors.green;
      case NotificationBannerType.error:
        return Colors.red;
      case NotificationBannerType.warning:
        return Colors.orange;
      case NotificationBannerType.info:
        return Colors.blue;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case NotificationBannerType.success:
        return Icons.check_circle;
      case NotificationBannerType.error:
        return Icons.error;
      case NotificationBannerType.warning:
        return Icons.warning;
      case NotificationBannerType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Material(
          elevation: 8,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
            ),
            child: Row(
              children: [
                Icon(_getIcon(), color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.showCloseButton)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: _dismiss,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
