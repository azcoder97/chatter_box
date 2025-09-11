import 'package:chatter_box/features/chat/models/chat_screen_args.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/chat_tile.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect if the current theme is dark or light
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatterBox"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey[850]
                    : Colors.grey[200], // Light/Dark mode background
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search users or chats...",
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none, // No border
                  enabledBorder: InputBorder.none, // No border when enabled
                  focusedBorder: InputBorder.none, // No border when focused
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  hintStyle: TextStyle(
                    color: isDarkMode
                        ? Colors.white54
                        : Colors.black45, // Light/Dark hint text
                  ),
                  iconColor: isDarkMode
                      ? Colors.white54
                      : Colors.black45, // Icon color
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return TweenAnimationBuilder(
                  tween: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ),
                  duration: Duration(milliseconds: 300 + index * 50),
                  curve: Curves.easeOut,
                  builder: (context, Offset offset, child) {
                    return Transform.translate(
                      offset: Offset(0, offset.dy * 50),
                      child: Opacity(opacity: 1 - offset.dy, child: child),
                    );
                  },
                  child: ChatTile(
                    name: "User $index",
                    lastMessage: "This is the last message from user $index",
                    time: "12:${index}0 PM",
                    avatarUrl: "https://i.pravatar.cc/150?img=$index",
                    isOnline: index % 2 == 0,
                    unreadCount: index % 3,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.chatScreen,
                        arguments: ChatScreenArgs(
                          userName: "User $index",
                          avatarUrl: "https://i.pravatar.cc/150?img=$index",
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
