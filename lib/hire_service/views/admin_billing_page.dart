import 'package:brd/hire_service/controllers/hire_service_controller.dart';
import 'package:brd/hire_service/models/billing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminBillingPage extends StatefulWidget {
  const AdminBillingPage({super.key});

  @override
  State<AdminBillingPage> createState() => _AdminBillingPageState();
}

class _AdminBillingPageState extends State<AdminBillingPage> {
  final HireServiceController controller = Get.put(HireServiceController());

  @override
  void initState() {
    super.initState();
    controller.loadAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billing & Salary Payments')),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.adminBillings.isEmpty &&
            controller.adminSalaryPayments.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadAdminData,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _sectionTitle('Owner Billing'),
              const SizedBox(height: 10),
              if (controller.adminBillings.isEmpty)
                const Text('No billing records found.')
              else
                ...controller.adminBillings.map(_billingCard),
              const SizedBox(height: 24),
              _sectionTitle('Driver Salary Payment History'),
              const SizedBox(height: 10),
              if (controller.adminSalaryPayments.isEmpty)
                const Text('No driver salary payments recorded yet.')
              else
                ...controller.adminSalaryPayments.map(
                  (payment) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.payments_outlined),
                      title: Text(
                        '${payment.driverName.isEmpty ? payment.driverEmail : payment.driverName} • ৳${payment.amount.toStringAsFixed(2)}',
                      ),
                      subtitle: Text(
                        '${payment.billingMonth}\n${payment.paymentMethod.replaceAll('_', ' ')} • ${payment.transactionId}',
                      ),
                      trailing: Text(payment.status.toUpperCase()),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              _sectionTitle('All Transactions'),
              const SizedBox(height: 10),
              if (controller.adminTransactions.isEmpty)
                const Text('No transactions found.')
              else
                ...controller.adminTransactions.map(
                  (t) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(t.transactionId.isEmpty ? 'Transaction' : t.transactionId),
                      subtitle: Text('৳${t.amount.toStringAsFixed(2)}\n${t.createdAt}'),
                      trailing: Text(t.status.toUpperCase()),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(String title) => Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      );

  Widget _billingCard(BillingModel billing) {
    final alreadyPaid = controller.adminSalaryPayments
        .any((payment) => payment.billingUuid == billing.uuid);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    billing.driverName.isEmpty ? 'Driver Service' : billing.driverName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
                Text(billing.status.toUpperCase()),
              ],
            ),
            const SizedBox(height: 8),
            Text('Month: ${billing.billingMonth}'),
            Text('Driver salary: ৳${billing.driverSalary.toStringAsFixed(2)}'),
            Text('BRD profit (10%): ৳${billing.appProfit.toStringAsFixed(2)}'),
            Text('Owner total: ৳${billing.amount.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            if (billing.status == 'paid' && !alreadyPaid)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _showPaySalaryDialog(billing),
                  icon: const Icon(Icons.payments_outlined),
                  label: const Text('Pay Driver Salary'),
                ),
              )
            else if (alreadyPaid)
              const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green),
                  SizedBox(width: 7),
                  Text('Driver salary already paid.'),
                ],
              )
            else
              const Text('Owner billing must be paid before salary can be paid.'),
          ],
        ),
      ),
    );
  }

  Future<void> _showPaySalaryDialog(BillingModel billing) async {
    final transactionController = TextEditingController();
    final notesController = TextEditingController();
    String method = 'bank';

    await showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Pay Driver Salary'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Driver: ${billing.driverName}'),
                const SizedBox(height: 4),
                Text(
                  'Salary: ৳${billing.driverSalary.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: transactionController,
                  decoration: const InputDecoration(
                    labelText: 'Transaction ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: method,
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'bank', child: Text('Bank Transfer')),
                    DropdownMenuItem(value: 'mobile_banking', child: Text('Mobile Banking')),
                    DropdownMenuItem(value: 'cash', child: Text('Cash')),
                    DropdownMenuItem(value: 'other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    if (value != null) setDialogState(() => method = value);
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (transactionController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transaction ID is required.')),
                  );
                  return;
                }
                Navigator.pop(dialogContext);
                await controller.payDriverSalary(
                  billingUuid: billing.uuid,
                  transactionId: transactionController.text.trim(),
                  paymentMethod: method,
                  notes: notesController.text.trim(),
                );
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );

    transactionController.dispose();
    notesController.dispose();
  }
}
