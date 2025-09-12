import 'package:chatter_box/features/chat/widgets/build_message_bubble_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Sample messages
    final messages = [
      Message(text: "Hi there!", isSender: true),
      Message(text: "Hello! How are you?", isSender: false),
      Message(text: "I'm good, thanks!", isSender: true),
      Message(text: "Let's start our chat.", isSender: false),
    ];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              'Online',
              style: TextStyle(fontSize: 12, color: Colors.greenAccent),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
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
                  child: buildMessageBubble(msg.text, msg.isSender, isDarkMode),
                );
              },
            ),
          ),

          // ✅ Removed Typing Indicator

          // Message Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkMode ? Colors.grey[850] : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 1.0, end: 1.0),
                  duration: const Duration(milliseconds: 100),
                  builder: (context, double scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.deepPurple,
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
