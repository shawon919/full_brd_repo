class HireNotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String initialHireUuid;
  final String initialHireStatus;
  final DateTime? createdAt;

  const HireNotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.initialHireUuid,
    required this.initialHireStatus,
    this.createdAt,
  });

  factory HireNotificationModel.fromJson(Map<String, dynamic> json) {
    final dynamic explicitUuid =
        json['initial_hire_uuid'] ?? json['initialHireUuid'] ?? json['hire_uuid'];

    String hireUuid = '';
    if (explicitUuid != null && explicitUuid.toString().trim().isNotEmpty) {
      hireUuid = explicitUuid.toString().trim();
    } else {
      // Older responses can contain the database FK integer in
      // initial_hire. That integer is not the UUID required by the
      // respond/confirm endpoints, so it must never be used as one.
      final dynamic hire = json['initial_hire'] ?? json['initialHire'];
      if (hire is Map) {
        final dynamic nestedUuid = hire['uuid'] ?? hire['hire_uuid'];
        if (nestedUuid != null) {
          hireUuid = nestedUuid.toString().trim();
        }
      }
    }

    return HireNotificationModel(
      id: int.tryParse((json['id'] ?? 0).toString()) ?? 0,
      title: (json['title'] ?? 'Notification').toString(),
      message: (json['message'] ?? '').toString(),
      type: (json['notification_type'] ?? json['type'] ?? 'general').toString(),
      isRead: json['is_read'] == true,
      initialHireUuid: hireUuid,
      initialHireStatus:
          (json['initial_hire_status'] ?? '').toString().trim().toLowerCase(),
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
    );
  }
}
