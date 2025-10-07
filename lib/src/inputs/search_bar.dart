import 'package:flutter/material.dart';

class MotionSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final String hintText;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color backgroundColor;
  final Color textColor;

  const MotionSearchBar({
    super.key,
    required this.onSearch,
    this.hintText = 'Search...',
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
  });

  @override
  MotionSearchBarState createState() => MotionSearchBarState();
}

class MotionSearchBarState extends State<MotionSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isExpanded = false;

  void _onSearchChanged(String value) {
    widget.onSearch(value);
  }

  void _toggleExpansion() {
    setState(() => _isExpanded = !_isExpanded);
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      width: _isExpanded ? double.infinity : 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isExpanded ? Icons.arrow_back : Icons.search,
              color: widget.textColor,
            ),
            onPressed: _toggleExpansion,
          ),
          if (_isExpanded) ...[
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: widget.textColor.withAlpha((0.6 * 255).toInt())),
                ),
                style: TextStyle(color: widget.textColor),
              ),
            ),
            if (_controller.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear, color: widget.textColor),
                onPressed: _clearSearch,
              ),
          ],
        ],
      ),
    );
  }
}
