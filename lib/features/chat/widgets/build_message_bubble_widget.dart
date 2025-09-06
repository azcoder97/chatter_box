import 'package:flutter/material.dart';

Widget buildMessageBubble(String text, bool isSender, bool isDarkMode) {
  return Align(
    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSender
            ? Colors.deepPurple
            : (isDarkMode ? Colors.grey[800] : Colors.grey[300]),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isSender ? 20 : 0),
          bottomRight: Radius.circular(isSender ? 0 : 20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSender
              ? Colors.white
              : (isDarkMode ? Colors.white : Colors.black87),
        ),
      ),
    ),
  );
}
