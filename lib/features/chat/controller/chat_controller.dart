import 'package:chatter_box/core/utils/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatter_box/features/chat/data/chat_repository.dart';
import 'package:chatter_box/features/chat/models/chat_message.dart';
import 'package:chatter_box/core/utils/logger.dart';

class ChatController extends GetxController {
  final ChatRepository repository;
  var messages = <ChatMessage>[].obs;
  final TextEditingController messageController = TextEditingController();
  final String currentUserId;

  ChatController(this.repository, this.currentUserId);

  @override
  void onInit() {
    super.onInit();
    _listenToMessages();
  }

  void _listenToMessages() {
    repository.getMessages().listen(
      (data) {
        messages.value = data;
        log.d('Messages updated: ${data.length}');
      },
      onError: (e) {
        final msg = FirebaseExceptionHandler.handleException(e);
        log.e('Failed to listen messages: $msg');
      },
    );
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final message = ChatMessage(
      id: '',
      text: text,
      senderId: currentUserId,
      timestamp: DateTime.now(),
    );

    try {
      await repository.sendMessage(message);
      messageController.clear();
    } catch (e) {
      final msg = FirebaseExceptionHandler.handleException(e);
      log.e('Send message error: $msg');
      Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
