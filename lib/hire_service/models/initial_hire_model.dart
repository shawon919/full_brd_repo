class InitialHireModel {
  final String uuid;
  final String driverName;
  final String driverEmail;
  final String driverPhone;
  final String userName;
  final String userEmail;
  final String userPhone;
  final double salary;
  final String status;
  final DateTime? createdAt;

  const InitialHireModel({
    required this.uuid,
    required this.driverName,
    required this.driverEmail,
    required this.driverPhone,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.salary,
    required this.status,
    this.createdAt,
  });

  factory InitialHireModel.fromJson(Map<String, dynamic> json) {
    return InitialHireModel(
      uuid: _string(json['uuid'] ?? json['hire_uuid'] ?? json['id']),
      driverName: _string(json['driver_name'] ?? json['driverName']),
      driverEmail: _string(json['driver_email'] ?? json['driverEmail']),
      driverPhone: _string(json['driver_phone'] ?? json['driver_phone_number'] ?? json['driverPhone']),
      userName: _string(json['user_name'] ?? json['userName'] ?? json['owner_name']),
      userEmail: _string(json['user_email'] ?? json['userEmail'] ?? json['owner_email']),
      userPhone: _string(json['user_phone'] ?? json['user_phone_number'] ?? json['userPhone'] ?? json['owner_phone']),
      salary: _double(json['salary']),
      status: _string(json['status'], fallback: 'pending'),
      createdAt: DateTime.tryParse(_string(json['created_at'] ?? json['createdAt'])),
    );
  }

  static String _string(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    return value.toString();
  }

  static double _double(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
