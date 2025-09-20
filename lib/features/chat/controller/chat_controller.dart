import 'dart:async';

import 'package:chatter_box/core/utils/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatter_box/features/chat/data/chat_repository.dart';
import 'package:chatter_box/features/chat/models/chat_message.dart';
import 'package:chatter_box/core/utils/logger.dart';

class ChatController extends GetxController {
  final ChatRepository repository;
  final String currentUserId;

  ChatController(this.repository, this.currentUserId);

  /// ✅ Make this late final so it is initialized once
  late final TextEditingController messageController = TextEditingController();

  /// ✅ Reactive list of messages
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  /// ✅ Keep track of subscription to cancel on close
  StreamSubscription<List<ChatMessage>>? _messagesSub;

  @override
  void onInit() {
    super.onInit();
    _listenToMessages();
  }

  void _listenToMessages() {
    _messagesSub = repository.getMessages().listen(
      (data) {
        messages.assignAll(data); // ✅ more efficient than messages.value =
        log.d('Messages updated: ${data.length}');
      },
      onError: (e) {
        final msg = FirebaseExceptionHandler.handleException(e);
        log.e('Failed to listen to messages: $msg');
        if (!Get.isSnackbarOpen) {
          Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
        }
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
      if (!Get.isSnackbarOpen) {
        Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  void onClose() {
    _messagesSub?.cancel(); // ✅ Prevent memory leaks
    messageController.dispose(); // ✅ Dispose controller safely
    super.onClose();
  }
}
