class SalaryPaymentModel {
  final String uuid;
  final String billingUuid;
  final String serviceUuid;
  final String driverName;
  final String driverEmail;
  final String ownerName;
  final String ownerEmail;
  final double amount;
  final String paymentMethod;
  final String transactionId;
  final String status;
  final String paidAt;
  final String billingMonth;

  const SalaryPaymentModel({
    required this.uuid,
    required this.billingUuid,
    required this.serviceUuid,
    required this.driverName,
    required this.driverEmail,
    required this.ownerName,
    required this.ownerEmail,
    required this.amount,
    required this.paymentMethod,
    required this.transactionId,
    required this.status,
    required this.paidAt,
    required this.billingMonth,
  });

  factory SalaryPaymentModel.fromJson(Map<String, dynamic> json) {
    return SalaryPaymentModel(
      uuid: _s(json['uuid']),
      billingUuid: _s(json['billing_uuid']),
      serviceUuid: _s(json['service_uuid']),
      driverName: _s(json['driver_name']),
      driverEmail: _s(json['driver_email']),
      ownerName: _s(json['owner_name']),
      ownerEmail: _s(json['owner_email']),
      amount: _d(json['amount'], _d(json['salary_amount'] ?? json['driver_salary'])),
      paymentMethod: _s(json['payment_method']),
      transactionId: _s(json['transaction_id']),
      status: _s(json['status'], fallback: 'completed'),
      paidAt: _s(json['paid_at']),
      billingMonth: _s(json['billing_month']),
    );
  }

  static String _s(dynamic value, {String fallback = ''}) =>
      value == null ? fallback : value.toString();

  static double _d(dynamic value, [double fallback = 0]) =>
      value is num ? value.toDouble() : double.tryParse(value?.toString() ?? '') ?? fallback;
}
