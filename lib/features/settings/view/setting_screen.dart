import 'package:chatter_box/core/bindings/theme_controller.dart';
import 'package:chatter_box/features/auth/services/firebase_auth_service.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final FirebaseAuthService authService = Get.find<FirebaseAuthService>();
    final user = authService.currentUser; // ✅ Get current user

    String getInitials(String name) {
      final parts = name.trim().split(' ');
      if (parts.isEmpty) return '';
      if (parts.length == 1) return parts[0][0].toUpperCase();
      return (parts[0][0] + parts.last[0]).toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 👤 Profile Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepPurple.withValues(alpha: 0.2),
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(
                              user!.photoURL!,
                            ) // ✅ If profile picture exists
                          : null, // ❌ No image, fallback to initials
                      child: user?.photoURL == null
                          ? Text(
                              getInitials(user?.displayName ?? "Guest User"),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? "Guest User",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? "guest@example.com",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color
                                      ?.withValues(alpha: 0.6),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ⚙️ Settings Options
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Obx(() {
                    return ListTile(
                      leading: const Icon(Icons.brightness_6_outlined),
                      title: const Text("Theme"),
                      subtitle: const Text(
                        "Choose system, light, or dark mode",
                      ),
                      trailing: DropdownButton<int>(
                        value: themeController.themeIndex.value,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          if (value != null) themeController.setTheme(value);
                        },
                        items: const [
                          DropdownMenuItem(value: 0, child: Text("System")),
                          DropdownMenuItem(value: 1, child: Text("Light")),
                          DropdownMenuItem(value: 2, child: Text("Dark")),
                        ],
                      ),
                    );
                  }),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: const Text("Notifications"),
                    subtitle: const Text("Enable or disable app notifications"),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // TODO: Handle notification toggle
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 🚪 Logout Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: () async {
                await authService.signOut();
                Get.offAllNamed(AppRoutes.signInScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
