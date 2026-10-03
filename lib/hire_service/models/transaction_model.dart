class TransactionModel {
  final String id;
  final String billingUuid;
  final double amount;
  final String transactionId;
  final String status;
  final String createdAt;

  const TransactionModel({
    required this.id,
    required this.billingUuid,
    required this.amount,
    required this.transactionId,
    required this.status,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: _s(json['id'] ?? json['uuid']),
      billingUuid: _s(json['billing_uuid'] ?? json['billing']),
      amount: _d(json['amount']),
      transactionId: _s(json['transaction_id']),
      status: _s(json['status'], fallback: 'paid'),
      createdAt: _s(json['created_at']),
    );
  }

  static String _s(dynamic v, {String fallback = ''}) => v == null ? fallback : v.toString();
  static double _d(dynamic v) => v is num ? v.toDouble() : double.tryParse(v?.toString() ?? '') ?? 0;
}
