import 'package:flutter/material.dart';

class SwipeableListItem extends StatefulWidget {
  final Widget child;
  final Widget? leftAction;
  final Widget? rightAction;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final double swipeThreshold;

  const SwipeableListItem({
    Key? key,
    required this.child,
    this.leftAction,
    this.rightAction,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.swipeThreshold = 100.0,
  }) : super(key: key);

  @override
  _SwipeableListItemState createState() => _SwipeableListItemState();
}

class _SwipeableListItemState extends State<SwipeableListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double _dragOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta.dx;

      // Limit drag distance
      if (widget.leftAction != null && _dragOffset > 0) {
        _dragOffset = _dragOffset.clamp(0, widget.swipeThreshold);
      } else if (widget.rightAction != null && _dragOffset < 0) {
        _dragOffset = _dragOffset.clamp(-widget.swipeThreshold, 0);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final shouldTriggerLeft = _dragOffset > widget.swipeThreshold * 0.6;
    final shouldTriggerRight = _dragOffset < -widget.swipeThreshold * 0.6;

    if (shouldTriggerLeft && widget.onSwipeLeft != null) {
      widget.onSwipeLeft!();
    } else if (shouldTriggerRight && widget.onSwipeRight != null) {
      widget.onSwipeRight!();
    }

    // Animate back to original position
    _controller.forward().then((_) {
      setState(() => _dragOffset = 0.0);
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Stack(
        children: [
          // Background actions
          if (widget.leftAction != null && _dragOffset > 0)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: widget.leftAction!,
                ),
              ),
            ),
          if (widget.rightAction != null && _dragOffset < 0)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: widget.rightAction!,
                ),
              ),
            ),
          // Main content
          Transform.translate(
            offset: Offset(_dragOffset, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}