import 'package:flutter/material.dart';

class AnimatedTabBar extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int> onTabChanged;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const AnimatedTabBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  AnimatedTabBarState createState() => AnimatedTabBarState();
}

class AnimatedTabBarState extends State<AnimatedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() => _currentIndex = _tabController.index);
      widget.onTabChanged(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        tabs: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          return AnimatedTab(
            text: tab,
            isActive: index == _currentIndex,
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
            animationDuration: widget.animationDuration,
            animationCurve: widget.animationCurve,
          );
        }).toList(),
        indicator: const BoxDecoration(),
        labelColor: Colors.transparent,
        unselectedLabelColor: Colors.transparent,
      ),
    );
  }
}

class AnimatedTab extends StatelessWidget {
  final String text;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const AnimatedTab({
    super.key,
    required this.text,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.animationDuration,
    required this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? activeColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : inactiveColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}