import 'package:brd/hire_service/api/hire_service_api.dart';
import 'package:brd/hire_service/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverNotificationController extends GetxController {
  final HireServiceApi api = HireServiceApi();

  final notifications = <HireNotificationModel>[].obs;
  final isLoading = false.obs;

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;
      final all = await api.getMyNotifications();

      // Drivers must never receive or see owner billing/payment notices.
      notifications.assignAll(
        all.where(_isDriverNotification).toList(),
      );
    } catch (e) {
      Get.snackbar(
        'Notifications',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _isDriverNotification(HireNotificationModel notification) {
    const allowed = {
      'hire_response',
      'hire_confirmed',
      'service',
      'driver_update',
      'payment',
      'general',
    };

    return allowed.contains(notification.type) &&
        notification.type != 'billing';
  }

  Future<void> markRead(int id) async {
    try {
      await api.markNotificationRead(id);
      final index = notifications.indexWhere((n) => n.id == id);
      if (index == -1) return;

      final old = notifications[index];
      notifications[index] = HireNotificationModel(
        id: old.id,
        title: old.title,
        message: old.message,
        type: old.type,
        isRead: true,
        initialHireUuid: old.initialHireUuid,
        initialHireStatus: old.initialHireStatus,
        createdAt: old.createdAt,
      );
    } catch (e) {
      Get.snackbar(
        'Notification',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
