import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  factory ChatMessage.fromMap(String id, Map<String, dynamic> data) {
    return ChatMessage(
      id: id,
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'text': text, 'senderId': senderId, 'timestamp': timestamp};
  }
}
