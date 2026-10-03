import 'package:brd/hire_service/api/hire_service_api.dart';
import 'package:brd/hire_service/controllers/hire_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNotificationsPage extends StatelessWidget {
  AdminNotificationsPage({super.key});
  final HireServiceController controller = Get.put(HireServiceController());
  final HireServiceApi api = HireServiceApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hire Notifications')),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.loadNotifications,
            child: ListView(children: const [SizedBox(height: 180), Center(child: Text('No admin notifications'))]),
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
              final isHireResponse =
                  n.type == 'hire_response' && n.initialHireUuid.isNotEmpty;
              final canConfirm =
                  isHireResponse && n.initialHireStatus == 'accepted';
              final canStartService =
                  isHireResponse && n.initialHireStatus == 'confirmed';
              return Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(n.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                    const SizedBox(height: 8),
                    Text(n.message),
                    if (canConfirm || canStartService) ...[
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: canConfirm
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('Confirm Hire'),
                                onPressed: () =>
                                    _confirm(context, n.initialHireUuid),
                              )
                            : OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.directions_car_outlined,
                                ),
                                label: const Text('Start Driver Service'),
                                onPressed: () => _startService(
                                  context,
                                  n.initialHireUuid,
                                ),
                              ),
                      ),
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

  Future<void> _confirm(BuildContext context, String uuid) async {
    try {
      final result = await api.confirmInitialHire(uuid);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message']?.toString() ?? 'Hire confirmed',
            ),
          ),
        );
      }
      await controller.loadNotifications();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceFirst('Exception: ', ''),
            ),
          ),
        );
      }
    }
  }

  Future<void> _startService(BuildContext context, String uuid) async {
    try {
      final result = await api.createDriverService(hireUuid: uuid);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message']?.toString() ?? 'Driver service created',
            ),
          ),
        );
      }
      await controller.loadNotifications();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceFirst('Exception: ', ''),
            ),
          ),
        );
      }
    }
  }
}
