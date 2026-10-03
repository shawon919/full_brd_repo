import 'package:brd/Car-Owner/templets/AccountView.dart';
import 'package:brd/Car-Owner/templets/ApplicationPage.dart';
import 'package:brd/Car-Owner/templets/UserAccountPage.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:brd/GETX/Routes/get_routes.dart';
import 'package:flutter/material.dart';
// TODO: add flutter_svg to pubspec.yaml
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Userprofile extends StatelessWidget {
  Userprofile({super.key});

  final Usergetxcontroller controller = Get.put(Usergetxcontroller());

  static const Color maroon = Color(0xFF800000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maroon,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ================= PROFILE HEADER =================
            _ProfileHeader(controller: controller),

            const SizedBox(height: 20),

            // ================= MENU CARD =================
            _MenuCard(controller: controller),

            const SizedBox(height: 20),

            // ================= LOGOUT =================
            _LogoutButton(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final Usergetxcontroller controller;

  final Usergetxcontroller userController = Get.find<Usergetxcontroller>();

  _ProfileHeader({required this.controller});

  static const Color maroon = Color(0xFF800000);

  @override
  Widget build(BuildContext context) {
    final String username = userController.box.read("fullName") ?? "User";
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF800000).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Obx(() {
            final img = controller.profilePicture.value;

            return CircleAvatar(
              radius: 34,
              backgroundColor: maroon.withOpacity(0.1),
              backgroundImage: img.isNotEmpty ? NetworkImage(img) : null,
              child: img.isEmpty
                  ? const Icon(Icons.person, color: maroon)
                  : null,
            );
          }),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back $username",
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Manage your account",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final Usergetxcontroller controller;

  const _MenuCard({required this.controller});

  static const Color maroon = Color(0xFF800000);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _tile(
            icon: Icons.person_outline,
            text: "My Account",
            onTap: () {
              String accessToken = controller.box.read("access_token") ?? "";
              controller.fetchUserProfile(accessToken);
              Get.to(() => Accountview());
            },
          ),

          _divider(),

          _tile(
            icon: Icons.notifications_none,
            text: "Application",
            onTap: () {
              String accessToken = controller.box.read("access_token") ?? "";
              controller.fetchUserOrder(accessToken);
              Get.to(() => Applicationpage());
            },
          ),

          _divider(),

          _tile(
            icon: Icons.settings_outlined,
            text: "Settings",
            onTap: () => Get.to(() => Useraccountpage()),
          ),

          _divider(),

          _tile(icon: Icons.help_outline, text: "Help Center", onTap: () {}),
        ],
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: maroon.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: maroon),
      ),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }

  Widget _divider() => const Divider(height: 1);
}

class _LogoutButton extends StatelessWidget {
  final Usergetxcontroller controller;

  const _LogoutButton({required this.controller});

  static const Color maroon = Color(0xFF800000);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Logout",
            middleText: "Are you sure you want to logout?",
            confirm: TextButton(
              onPressed: () {
                Get.back();
                controller.logout();
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
            cancel: TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: maroon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Log Out",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
