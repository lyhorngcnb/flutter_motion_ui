
import 'package:flutter/material.dart';

class ExpandableListItem extends StatefulWidget {
  final Widget header;
  final Widget expandedContent;
  final bool initiallyExpanded;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? backgroundColor;

  const ExpandableListItem({
    super.key,
    required this.header,
    required this.expandedContent,
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.backgroundColor,
  });

  @override
  ExpandableListItemState createState() => ExpandableListItemState();
}

class ExpandableListItemState extends State<ExpandableListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );
    _isExpanded = widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggleExpansion,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: widget.header),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                      child: const Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expandable content
          SizeTransition(
            sizeFactor: _animation,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: widget.expandedContent,
            ),
          ),
        ],
      ),
    );
  }
}