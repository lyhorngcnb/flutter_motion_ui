import 'package:flutter/material.dart';

class MotionDrawer extends StatefulWidget {
  final Widget header;
  final List<MotionDrawerItem> items;
  final Color backgroundColor;
  final double width;
  final Duration animationDuration;
  final Curve animationCurve;

  const MotionDrawer({
    Key? key,
    required this.header,
    required this.items,
    this.backgroundColor = Colors.white,
    this.width = 280,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  static void open(BuildContext context, MotionDrawer drawer) {
    Scaffold.of(context).openDrawer();
  }

  @override
  _MotionDrawerState createState() => _MotionDrawerState();
}

class _MotionDrawerState extends State<MotionDrawer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: widget.backgroundColor,
      width: widget.width,
      child: Column(
        children: [
          // Header
          widget.header,
          // Items
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return widget.items[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MotionDrawerItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const MotionDrawerItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  }) : super(key: key);

  @override
  _MotionDrawerItemState createState() => _MotionDrawerItemState();
}

class _MotionDrawerItemState extends State<MotionDrawerItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? widget.selectedColor.withOpacity(0.1)
                  : _isHovered
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.transparent,
              border: widget.isSelected
                  ? Border(
                left: BorderSide(
                  color: widget.selectedColor,
                  width: 3,
                ),
              )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? widget.selectedColor
                      : widget.unselectedColor,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: widget.isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: widget.isSelected
                        ? widget.selectedColor
                        : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
