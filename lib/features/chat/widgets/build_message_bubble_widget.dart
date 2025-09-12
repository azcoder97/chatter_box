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

    final messages = [
      Message(text: "Hey 👋", isSender: true),
      Message(text: "Hi! How's it going?", isSender: false),
      Message(text: "All good, building a Flutter app 😍", isSender: true),
      Message(text: "Nice! Let's test this chat screen!", isSender: false),
    ];

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            CircleAvatar(radius: 18, backgroundImage: NetworkImage(avatarUrl)),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const Text(
                  "Online",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return TweenAnimationBuilder(
                  tween: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ),
                  duration: Duration(milliseconds: 250 + index * 50),
                  builder: (context, offset, child) => Transform.translate(
                    offset: Offset(0, (offset).dy * 30),
                    child: Opacity(opacity: 1 - offset.dy, child: child),
                  ),
                  child: buildMessageBubble(msg.text, msg.isSender, isDarkMode),
                );
              },
            ),
          ),

          // Typing Indicator
          buildTypingIndicator(isDarkMode),

          // Chat Input Bar
          buildInputBar(isDarkMode),
        ],
      ),
    );
  }

  Widget buildTypingIndicator(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const CircleAvatar(radius: 14, backgroundColor: Colors.grey),
          const SizedBox(width: 8),
          ...List.generate(3, (i) => animatedDot(isDarkMode, i)),
        ],
      ),
    );
  }

  Widget buildInputBar(bool isDarkMode) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 22,
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMessageBubble(String text, bool isSender, bool isDarkMode) {
  return Align(
    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: isSender
            ? Colors.deepPurple
            : (isDarkMode ? Colors.grey[800] : Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isSender ? 16 : 0),
          bottomRight: Radius.circular(isSender ? 0 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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

Widget animatedDot(bool isDarkMode, int index) {
  return TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 500 + index * 150),
    tween: Tween(begin: 0.3, end: 1.0),
    curve: Curves.easeInOut,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: CircleAvatar(
            radius: 3,
            backgroundColor: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      );
    },
  );
}

class Message {
  final String text;
  final bool isSender;
  Message({required this.text, required this.isSender});
}
