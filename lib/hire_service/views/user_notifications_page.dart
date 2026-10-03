import 'package:brd/hire_service/controllers/hire_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNotificationsPage extends StatelessWidget {
  UserNotificationsPage({super.key});

  final HireServiceController controller = Get.put(HireServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.loadNotifications,
            child: ListView(children: const [SizedBox(height: 180), Center(child: Text('No notifications'))]),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadNotifications,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final n = controller.notifications[index];
              final isHire =
                  n.type == 'hire_offer' &&
                  n.initialHireUuid.isNotEmpty &&
                  n.initialHireStatus == 'pending';
              return Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Icon(n.isRead ? Icons.notifications_none : Icons.notifications_active, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Expanded(child: Text(n.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16))),
                    ]),
                    const SizedBox(height: 10),
                    Text(n.message),
                    if (isHire) ...[
                      const SizedBox(height: 14),
                      Row(children: [
                        Expanded(child: OutlinedButton(onPressed: controller.isLoading.value ? null : () => controller.respondToHire(n.initialHireUuid, false), child: const Text('Reject'))),
                        const SizedBox(width: 10),
                        Expanded(child: ElevatedButton(onPressed: controller.isLoading.value ? null : () => controller.respondToHire(n.initialHireUuid, true), child: const Text('Accept'))),
                      ]),
                    ],
                    if (!n.isRead) Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => controller.markRead(n.id), child: const Text('Mark as read'))),
                  ]),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
