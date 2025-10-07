import 'package:flutter/material.dart';

class MenuSheet extends StatelessWidget {
  final String title;
  final List<MenuSheetItem> items;
  final Color backgroundColor;
  final Color textColor;

  const MenuSheet({
    super.key,
    required this.title,
    required this.items,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
  });

  static void show({
    required BuildContext context,
    required String title,
    required List<MenuSheetItem> items,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black87,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MenuSheet(
        title: title,
        items: items,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            // Items
            ...items.map((item) => MenuSheetItemWidget(
              item: item,
              textColor: textColor,
            )),
            // Cancel button
            const SizedBox(height: 8),
            Container(
              height: 6,
              color: Colors.grey[200],
            ),
            MenuSheetItemWidget(
              item: MenuSheetItem(
                text: 'Cancel',
                icon: Icons.close,
                onTap: () => Navigator.pop(context),
                isDestructive: false,
              ),
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuSheetItem {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const MenuSheetItem({
    required this.text,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
}

class MenuSheetItemWidget extends StatelessWidget {
  final MenuSheetItem item;
  final Color textColor;

  const MenuSheetItemWidget({
    super.key,
    required this.item,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          item.onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                item.icon,
                color: item.isDestructive
                    ? Colors.red
                    : textColor.withAlpha((0.7 * 255).toInt()), // 70% opacity
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                item.text,
                style: TextStyle(
                  fontSize: 16,
                  color: item.isDestructive ? Colors.red : textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}