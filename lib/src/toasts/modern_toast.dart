import 'package:flutter/material.dart';

class ModernToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    bool showIcon = true,
    bool showCloseButton = false,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? textColor,
    double borderRadius = 12.0,
    double elevation = 8.0,
  }) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry; // Declare first

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        position: position,
        duration: duration,
        showIcon: showIcon,
        showCloseButton: showCloseButton,
        onTap: onTap,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderRadius: borderRadius,
        elevation: elevation,
        onDismiss: () => overlayEntry.remove(), // Now works fine
      ),
    );

    overlay.insert(overlayEntry);
  }

  // Convenience methods for different toast types
  static void showSuccess({
    required BuildContext context,
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    bool showIcon = true,
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.success,
      position: position,
      duration: duration,
      showIcon: showIcon,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    bool showIcon = true,
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.error,
      position: position,
      duration: duration,
      showIcon: showIcon,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    bool showIcon = true,
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.warning,
      position: position,
      duration: duration,
      showIcon: showIcon,
    );
  }

  static void showInfo({
    required BuildContext context,
    required String message,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    bool showIcon = true,
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.info,
      position: position,
      duration: duration,
      showIcon: showIcon,
    );
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final ToastPosition position;
  final Duration duration;
  final bool showIcon;
  final bool showCloseButton;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double elevation;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.position,
    required this.duration,
    required this.showIcon,
    required this.showCloseButton,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.elevation,
    required this.onDismiss,
  });

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Different animation curves for enter and exit
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInBack,
    );

    _slideAnimation = Tween<Offset>(
      begin: _getInitialOffset(),
      end: Offset.zero,
    ).animate(curvedAnimation);

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(curvedAnimation);

    _controller.forward();

    // Auto dismiss after duration
    if (widget.duration != Duration.zero) {
      Future.delayed(widget.duration, _dismiss);
    }
  }

  Offset _getInitialOffset() {
    switch (widget.position) {
      case ToastPosition.top:
        return const Offset(0, -1);
      case ToastPosition.bottom:
        return const Offset(0, 1);
      case ToastPosition.center:
        return const Offset(0, -0.5);
    }
  }

  void _dismiss() {
    if (_controller.isCompleted) {
      _controller.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  void _onTap() {
    widget.onTap?.call();
    _dismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Positioned(
      top: widget.position == ToastPosition.top ? 80 : null,
      bottom: widget.position == ToastPosition.bottom ? 80 : null,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            ),
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: _onTap,
              child: Container(
                constraints: const BoxConstraints(minHeight: 60),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? _getBackgroundColor(colorScheme),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255) .toInt()),
                      blurRadius: widget.elevation,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: _getBorderColor(colorScheme),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showIcon) ...[
                      Icon(
                        _getIcon(),
                        color: widget.textColor ?? _getTextColor(colorScheme),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        widget.message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: widget.textColor ?? _getTextColor(colorScheme),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.showCloseButton) ...[
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _dismiss,
                        child: Icon(
                          Icons.close,
                          color: widget.textColor ?? _getTextColor(colorScheme),
                          size: 16,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    switch (widget.type) {
      case ToastType.success:
        return Colors.green.shade50;
      case ToastType.error:
        return Colors.red.shade50;
      case ToastType.warning:
        return Colors.orange.shade50;
      case ToastType.info:
        return Colors.blue.shade50;
    }
  }

  Color _getTextColor(ColorScheme colorScheme) {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.type) {
      case ToastType.success:
        return Colors.green.shade800;
      case ToastType.error:
        return Colors.red.shade800;
      case ToastType.warning:
        return Colors.orange.shade800;
      case ToastType.info:
        return Colors.blue.shade800;
    }
  }

  Color _getBorderColor(ColorScheme colorScheme) {
    switch (widget.type) {
      case ToastType.success:
        return Colors.green.shade200;
      case ToastType.error:
        return Colors.red.shade200;
      case ToastType.warning:
        return Colors.orange.shade200;
      case ToastType.info:
        return Colors.blue.shade200;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}

enum ToastType {
  success,
  error,
  warning,
  info,
}

enum ToastPosition {
  top,
  bottom,
  center,
}