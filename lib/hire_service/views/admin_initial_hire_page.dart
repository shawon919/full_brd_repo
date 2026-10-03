import 'package:brd/hire_service/api/hire_service_api.dart';
import 'package:flutter/material.dart';

class AdminInitialHirePage extends StatefulWidget {
  const AdminInitialHirePage({super.key});

  @override
  State<AdminInitialHirePage> createState() => _AdminInitialHirePageState();
}

class _AdminInitialHirePageState extends State<AdminInitialHirePage> {
  final _formKey = GlobalKey<FormState>();

  final driverEmail = TextEditingController();
  final driverPhone = TextEditingController();
  final userEmail = TextEditingController();
  final userPhone = TextEditingController();
  final salary = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    driverEmail.dispose();
    driverPhone.dispose();
    userEmail.dispose();
    userPhone.dispose();
    salary.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final result = await HireServiceApi().createInitialHire(
        driverEmail: driverEmail.text.trim(),
        driverPhone: driverPhone.text.trim(),
        userEmail: userEmail.text.trim(),
        userPhone: userPhone.text.trim(),
        salary: double.parse(salary.text.trim()),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ?? 'Initial hire created',
          ),
        ),
      );

      _formKey.currentState!.reset();
      driverEmail.clear();
      driverPhone.clear();
      userEmail.clear();
      userPhone.clear();
      salary.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboard,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  String? salaryValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    if (double.tryParse(value.trim()) == null) return 'Enter a valid amount';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Initial Hire')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Initial Hire Offer',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create an offer for a registered driver and car owner.',
                  ),
                  const SizedBox(height: 24),
                  field(
                    driverEmail,
                    'Driver email',
                    Icons.email_outlined,
                    keyboard: TextInputType.emailAddress,
                    validator: requiredField,
                  ),
                  field(
                    driverPhone,
                    'Driver phone',
                    Icons.phone_outlined,
                    keyboard: TextInputType.phone,
                    validator: requiredField,
                  ),
                  field(
                    userEmail,
                    'Owner email',
                    Icons.person_outline,
                    keyboard: TextInputType.emailAddress,
                    validator: requiredField,
                  ),
                  field(
                    userPhone,
                    'Owner phone',
                    Icons.phone_android_outlined,
                    keyboard: TextInputType.phone,
                    validator: requiredField,
                  ),
                  field(
                    salary,
                    'Monthly salary',
                    Icons.payments_outlined,
                    keyboard: const TextInputType.numberWithOptions(decimal: true),
                    validator: salaryValidator,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: loading ? null : submit,
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Create Hire Offer'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
