import 'package:chatter_box/core/services/firestore_service.dart';
import 'package:chatter_box/core/utils/exceptions.dart';
import 'package:chatter_box/features/chat/models/chat_message.dart';
import 'package:chatter_box/core/utils/logger.dart';

class ChatRepository {
  final FirestoreService firestore;

  ChatRepository(this.firestore);

  Stream<List<ChatMessage>> getMessages() {
    return firestore.getCollectionStream('chats').map((snapshot) {
      final messages = snapshot.docs
          .map((doc) => ChatMessage.fromMap(doc.id, doc.data()))
          .toList();
      log.d('Fetched ${messages.length} messages');
      return messages;
    });
  }

  Future<void> sendMessage(ChatMessage message) async {
    try {
      await firestore.addDocument('chats', message.toMap());
      log.i('Message sent: ${message.text}');
    } catch (e) {
      final msg = FirebaseExceptionHandler.handleException(e);
      log.e('Failed to send message: $msg');
      rethrow;
    }
  }
}
