import 'package:brd/hire_service/controllers/hire_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTransactionsPage extends StatefulWidget {
  const UserTransactionsPage({super.key});
  @override
  State<UserTransactionsPage> createState() => _UserTransactionsPageState();
}

class _UserTransactionsPageState extends State<UserTransactionsPage> {
  final HireServiceController controller = Get.put(HireServiceController());

  @override
  void initState() {
    super.initState();
    controller.loadTransactions();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My Transactions')),
        body: Obx(() {
          if (controller.isLoading.value && controller.transactions.isEmpty) return const Center(child: CircularProgressIndicator());
          if (controller.transactions.isEmpty) return const Center(child: Text('No transactions found'));
          return RefreshIndicator(
            onRefresh: controller.loadTransactions,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final t = controller.transactions[i];
                return Card(elevation: 0, child: ListTile(title: Text(t.transactionId.isEmpty ? 'Transaction' : t.transactionId, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text('${t.createdAt}\n৳${t.amount.toStringAsFixed(2)}'), trailing: Text(t.status.toUpperCase())));
              },
            ),
          );
        }),
      );
}
