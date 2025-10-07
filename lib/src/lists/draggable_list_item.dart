import 'package:flutter/material.dart';

class DraggableListItem extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragCompleted;
  final VoidCallback? onDragCancelled;
  final bool isDraggable;

  const DraggableListItem({
    super.key,
    required this.child,
    this.onDragStarted,
    this.onDragCompleted,
    this.onDragCancelled,
    this.isDraggable = true,
  });

  @override
  DraggableListItemState createState() => DraggableListItemState();
}

class DraggableListItemState extends State<DraggableListItem> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Widget>(
      data: widget.child,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Opacity(
          opacity: 0.8,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: widget.child,
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: widget.child,
      ),
      onDragStarted: () {
        setState(() => _isDragging = true);
        widget.onDragStarted?.call();
      },
      onDragCompleted: () {
        setState(() => _isDragging = false);
        widget.onDragCompleted?.call();
      },
      onDraggableCanceled: (_, __) {
        setState(() => _isDragging = false);
        widget.onDragCancelled?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: _isDragging
              ? Border.all(color: Colors.blue, width: 2)
              : null,
        ),
        child: widget.child,
      ),
    );
  }
}
