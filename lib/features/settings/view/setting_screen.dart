import 'package:chatter_box/core/bindings/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
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
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      backgroundImage: const NetworkImage(
                        "https://ui-avatars.com/api/?name=Guest+User",
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Guest User",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "guest@example.com",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color
                            ?.withOpacity(0.7),
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
                      subtitle: const Text("Choose system, light, or dark mode"),
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
              onPressed: () {
                // TODO: Connect with your AuthController
              },
            ),
          ],
        ),
      ),
    );
  }
}

