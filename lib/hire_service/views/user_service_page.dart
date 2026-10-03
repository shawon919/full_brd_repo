import 'package:brd/hire_service/controllers/hire_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserServicePage extends StatefulWidget {
  const UserServicePage({super.key});

  @override
  State<UserServicePage> createState() => _UserServicePageState();
}

class _UserServicePageState extends State<UserServicePage> {
  final HireServiceController controller = Get.put(HireServiceController());

  @override
  void initState() {
    super.initState();
    controller.loadServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Driver Service')),
      body: Obx(() {
        if (controller.isLoading.value && controller.services.isEmpty) return const Center(child: CircularProgressIndicator());
        if (controller.services.isEmpty) return const Center(child: Text('No active driver service'));
        return RefreshIndicator(
          onRefresh: controller.loadServices,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.services.length,
            itemBuilder: (_, i) {
              final s = controller.services[i];
              return Card(elevation: 0, margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.driverName, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('Driver phone: ${s.driverPhone}'),
                Text('Salary: ৳${s.salary.toStringAsFixed(2)} / month'),
                Text('Joining date: ${s.joiningDate}'),
                Text('Duration: ${s.durationDays} days (${s.durationMonths.toStringAsFixed(2)} months)'),
                Text('Status: ${s.status}'),
              ])));
            },
          ),
        );
      }),
    );
  }
}
