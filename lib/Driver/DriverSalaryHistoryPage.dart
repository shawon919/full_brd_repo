import 'package:brd/hire_service/api/hire_service_api.dart';
import 'package:brd/hire_service/models/salary_payment_model.dart';
import 'package:flutter/material.dart';

class DriverSalaryHistoryPage extends StatefulWidget {
  const DriverSalaryHistoryPage({super.key});

  @override
  State<DriverSalaryHistoryPage> createState() => _DriverSalaryHistoryPageState();
}

class _DriverSalaryHistoryPageState extends State<DriverSalaryHistoryPage> {
  final HireServiceApi api = HireServiceApi();
  bool loading = true;
  List<SalaryPaymentModel> payments = [];

  static const primary = Color(0xFF123B35);
  static const background = Color(0xFFF4F7F6);
  static const accent = Color(0xFF18A999);

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);
    try {
      payments = await api.getMySalaryPayments();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Salary Payment History'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: load,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : payments.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 180),
                      Icon(Icons.account_balance_wallet_outlined, size: 58, color: accent),
                      SizedBox(height: 14),
                      Center(child: Text('No salary payments yet.')),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: payments.length,
                    itemBuilder: (_, index) => _paymentCard(payments[index]),
                  ),
      ),
    );
  }

  Widget _paymentCard(SalaryPaymentModel payment) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F8F1),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(Icons.payments_outlined, color: accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '৳${payment.amount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      Text(payment.billingMonth, style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                Text(
                  payment.status.toUpperCase(),
                  style: const TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const Divider(height: 24),
            _row('Owner', payment.ownerName.isEmpty ? payment.ownerEmail : payment.ownerName),
            _row('Payment method', payment.paymentMethod.replaceAll('_', ' ')),
            _row('Transaction ID', payment.transactionId),
            _row('Paid at', payment.paidAt),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 115, child: Text(label, style: const TextStyle(color: Colors.black54))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
