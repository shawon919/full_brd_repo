import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DriverNotificationController.dart';

class DriverNotificationsPage extends StatelessWidget {
  DriverNotificationsPage({super.key});

  final DriverNotificationController controller =
      Get.put(DriverNotificationController(), permanent: false);

  static const Color primary = Color(0xFF123B35);
  static const Color accent = Color(0xFF18A999);
  static const Color background = Color(0xFFF4F7F6);
  static const Color textPrimary = Color(0xFF17211F);
  static const Color textSecondary = Color(0xFF6D7976);
  static const Color border = Color(0xFFE1E8E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: const Text(
          'Driver Notifications',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: accent));
        }

        if (controller.notifications.isEmpty) {
          return RefreshIndicator(
            color: accent,
            onRefresh: controller.loadNotifications,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 180),
                Icon(Icons.notifications_none_rounded, size: 64, color: textSecondary),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'No driver notifications yet',
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Center(
                  child: Text(
                    'Hire and service updates will appear here.',
                    style: TextStyle(color: textSecondary, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: accent,
          onRefresh: controller.loadNotifications,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final notification = controller.notifications[index];
              return _notificationCard(notification);
            },
          ),
        );
      }),
    );
  }

  Widget _notificationCard(dynamic notification) {
    final bool unread = !notification.isRead;
    final IconData icon = _iconForType(notification.type);

    return InkWell(
      onTap: () {
        if (unread) controller.markRead(notification.id);
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: unread ? const Color(0xFFEAF8F4) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A123B35),
              blurRadius: 16,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: accent.withOpacity(.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: primary, size: 21),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: const TextStyle(
                            color: textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (unread)
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    notification.message,
                    style: const TextStyle(
                      color: textSecondary,
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                  if (notification.createdAt != null) ...[
                    const SizedBox(height: 9),
                    Text(
                      _formatDate(notification.createdAt),
                      style: const TextStyle(
                        color: textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'hire_response':
        return Icons.assignment_turned_in_outlined;
      case 'hire_confirmed':
        return Icons.verified_outlined;
      case 'service':
        return Icons.directions_car_outlined;
      case 'driver_update':
        return Icons.campaign_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '';
    final local = value.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}/${local.year}  $hour:$minute';
  }
}
