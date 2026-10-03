class BillingModel {
  final String uuid;
  final String serviceUuid;
  final double amount;
  final double driverSalary;
  final double appProfit;
  final String billingMonth;
  final String dueDate;
  final String status;
  final String driverName;
  final String userEmail;
  final String transactionId;

  const BillingModel({
    required this.uuid,
    required this.serviceUuid,
    required this.amount,
    required this.driverSalary,
    required this.appProfit,
    required this.billingMonth,
    required this.dueDate,
    required this.status,
    required this.driverName,
    required this.userEmail,
    required this.transactionId,
  });

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      uuid: _s(json['uuid'] ?? json['billing_uuid'] ?? json['id']),
      serviceUuid: _s(json['service_uuid'] ?? json['service'] ?? json['service_id']),
      amount: _d(json['amount']),
      driverSalary: _d(json['driver_salary'] ?? json['salary'] ?? json['salary_amount'], _d(json['amount']) > 0 ? _d(json['amount']) / 1.10 : 0),
      appProfit: _d(json['app_profit']),
      billingMonth: _s(json['billing_month'] ?? json['month']),
      dueDate: _s(json['due_date']),
      status: _s(json['status'], fallback: 'pending'),
      driverName: _s(json['driver_name']),
      userEmail: _s(json['user_email']),
      transactionId: _s(json['transaction_id']),
    );
  }

  static String _s(dynamic v, {String fallback = ''}) => v == null ? fallback : v.toString();
  static double _d(dynamic v, [double fallback = 0]) => v is num ? v.toDouble() : double.tryParse(v?.toString() ?? '') ?? fallback;
}
