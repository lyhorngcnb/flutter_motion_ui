import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  final List<String> imageUrls;
  final double avatarSize;
  final double overlapFactor;
  final int maxAvatars;
  final Color borderColor;
  final double borderWidth;

  const AvatarStack({
    Key? key,
    required this.imageUrls,
    this.avatarSize = 40,
    this.overlapFactor = 0.7,
    this.maxAvatars = 4,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleAvatars = imageUrls.take(maxAvatars).toList();
    final remainingCount = imageUrls.length - visibleAvatars.length;

    return SizedBox(
      height: avatarSize,
      child: Stack(
        children: [
          ...visibleAvatars.asMap().entries.map((entry) {
            final index = entry.key;
            final imageUrl = entry.value;
            return Positioned(
              left: index * avatarSize * overlapFactor,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: borderWidth,
                  ),
                ),
                child: CircleAvatar(
                  // imageUrl: imageUrl,
                  // size: avatarSize - borderWidth * 2,
                ),
              ),
            );
          }),
          if (remainingCount > 0)
            Positioned(
              left: visibleAvatars.length * avatarSize * overlapFactor,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: borderWidth,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$remainingCount',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: avatarSize * 0.25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}