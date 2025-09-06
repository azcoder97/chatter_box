// lib/features/chat/widgets/avatar_widget.dart
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;
  final double radius;

  const AvatarWidget({
    super.key,
    required this.imageUrl,
    this.isOnline = false,
    this.radius = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(radius: radius, backgroundImage: NetworkImage(imageUrl)),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: radius / 2,
              height: radius / 2,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
