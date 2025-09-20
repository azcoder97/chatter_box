import 'package:chatter_box/features/auth/services/firebase_auth_service.dart';
import 'package:chatter_box/features/chat/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:chatter_box/core/services/firestore_service.dart';
import 'package:chatter_box/features/chat/data/chat_repository.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Ensure AuthService is available (if not, inject it)
    if (!Get.isRegistered<FirebaseAuthService>()) {
      Get.lazyPut(() => FirebaseAuthService(), fenix: true);
    }

    Get.lazyPut(() => FirestoreService(), fenix: true);
    Get.lazyPut(
      () => ChatRepository(Get.find<FirestoreService>()),
      fenix: true,
    );

    // ✅ Get current logged-in user
    final authService = Get.find<FirebaseAuthService>();
    final currentUserId = authService.currentUser?.uid ?? '';

    // ✅ Create ChatController with correct userId
    Get.lazyPut(
      () => ChatController(Get.find<ChatRepository>(), currentUserId),
      fenix: true, // ✅ Auto recreate if disposed
    );
  }
}
