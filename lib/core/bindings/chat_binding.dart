import 'package:chatter_box/features/chat/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:chatter_box/core/services/firestore_service.dart';
import 'package:chatter_box/features/chat/data/chat_repository.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FirestoreService(),
    ); // ✅ Provides a single FirestoreService instance (handles Firebase calls)
    Get.lazyPut(
      () => ChatRepository(Get.find<FirestoreService>()),
    ); // ✅ Creates ChatRepository using FirestoreService
    Get.lazyPut(
      () => ChatController(Get.find<ChatRepository>(), ''),
    ); // ✅ Creates ChatController using ChatRepository
  }
}
