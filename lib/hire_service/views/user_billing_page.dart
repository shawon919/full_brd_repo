import 'package:brd/hire_service/controllers/hire_service_controller.dart';
import 'package:brd/hire_service/models/billing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserBillingPage extends StatefulWidget {
  const UserBillingPage({super.key});

  @override
  State<UserBillingPage> createState() => _UserBillingPageState();
}

class _UserBillingPageState extends State<UserBillingPage> {
  final HireServiceController controller = Get.put(HireServiceController());

  @override
  void initState() {
    super.initState();
    controller.loadBilling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Billing')),
      body: Obx(() {
        if (controller.isLoading.value && controller.billings.isEmpty) return const Center(child: CircularProgressIndicator());
        if (controller.billings.isEmpty) return const Center(child: Text('No billing records'));
        return RefreshIndicator(
          onRefresh: controller.loadBilling,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.billings.length,
            itemBuilder: (_, i) => _BillingCard(billing: controller.billings[i], controller: controller),
          ),
        );
      }),
    );
  }
}

class _BillingCard extends StatelessWidget {
  final BillingModel billing;
  final HireServiceController controller;
  const _BillingCard({required this.billing, required this.controller});

  @override
  Widget build(BuildContext context) {
    final paid = billing.status.toLowerCase() == 'paid';
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Expanded(child: Text(billing.driverName.isEmpty ? 'Driver Service' : billing.driverName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17))), _Status(status: billing.status)]),
          const SizedBox(height: 12),
          Text('Amount: ৳${billing.amount.toStringAsFixed(2)}'),
          Text('Billing month: ${billing.billingMonth}'),
          Text('Due date: ${billing.dueDate}'),
          if (!paid) ...[
            const SizedBox(height: 14),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(icon: const Icon(Icons.payment), label: const Text('Pay Billing'), onPressed: () => _showPaymentDialog(context))),
          ],
        ]),
      ),
    );
  }

  Future<void> _showPaymentDialog(BuildContext context) async {
    final text = TextEditingController();
    await showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Submit Payment'), content: TextField(controller: text, decoration: const InputDecoration(labelText: 'Transaction ID', border: OutlineInputBorder())), actions: [TextButton(onPressed: Get.back, child: const Text('Cancel')), ElevatedButton(onPressed: () { final id = text.text.trim(); if (id.isEmpty) return; Get.back(); controller.payBilling(billing.uuid, id); }, child: const Text('Submit'))]));
  }
}

class _Status extends StatelessWidget {
  final String status;
  const _Status({required this.status});
  @override
  Widget build(BuildContext context) => Chip(label: Text(status.toUpperCase()), visualDensity: VisualDensity.compact);
}
