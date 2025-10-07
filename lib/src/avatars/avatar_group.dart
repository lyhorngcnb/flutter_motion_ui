import 'package:flutter/material.dart';

class AvatarGroup extends StatelessWidget {
  final List<Widget> avatars;
  final double avatarSize;
  final double spacing;
  final MainAxisAlignment alignment;

  const AvatarGroup({
    super.key,
    required this.avatars,
    this.avatarSize = 40,
    this.spacing = -10,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        for (int i = 0; i < avatars.length; i++)
          Container(
            margin: EdgeInsets.only(
              left: i == 0 ? 0 : spacing,
            ),
            child: avatars[i],
          ),
      ],
    );
  }
}
