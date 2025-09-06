// Message Bubble
import 'package:flutter/material.dart';



// Animated Typing Dot
Widget animatedDot(bool isDarkMode, int index) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.5, end: 1.0),
    duration: Duration(milliseconds: 500 + index * 200),
    curve: Curves.easeInOut,
    builder: (context, scale, child) {
      return Transform.scale(
        scale: scale,
        child: Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white : Colors.black,
            shape: BoxShape.circle,
          ),
        ),
      );
    },
    onEnd: () {},
  );
}