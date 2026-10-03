import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';

class Applicationpage extends StatelessWidget {
  Applicationpage({super.key});

  final Usergetxcontroller controller = Get.put(Usergetxcontroller());

  // Controllers
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController salaryCtrl = TextEditingController();
  final TextEditingController experienceCtrl = TextEditingController();
  final TextEditingController workingHoursCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();
  final TextEditingController createdAtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application'),
        centerTitle: true,
        backgroundColor: Color(0xFF800000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _hasApplicationData()
            ? _buildFormView(context)
            : _buildEmptyView(context),
      ),
    );
  }

  bool _hasApplicationData() {
    return _isNotEmpty('location') &&
        _isNotEmpty('salary') &&
        _isNotEmpty('experience') &&
        _isNotEmpty('working_hours') &&
        _isNotEmpty('contact_number') &&
        _isNotEmpty('created_at');
  }

  bool _isNotEmpty(String key) {
    final value = controller.box.read(key);
    return value != null && value.toString().trim().isNotEmpty;
  }

  Widget _buildFormView(BuildContext context) {
  String location = controller.box.read('location') ?? 'N/A';
  String salary = controller.box.read('salary') ?? 'N/A';
  String experience = controller.box.read('experience') ?? 'N/A';
  String workingHours = controller.box.read('working_hours') ?? 'N/A';
  String contactNumber = controller.box.read('contact_number') ?? 'N/A';
  String createdAt = controller.box.read('created_at') ?? 'N/A';

  const Color maroon = Color(0xFF800000);

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // ================= INFO CARD =================
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: maroon.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              _infoTile("Location", location),
              _divider(),
              _infoTile("Salary", salary),
              _divider(),
              _infoTile("Experience", experience),
              _divider(),
              _infoTile("Working Hours", workingHours),
              _divider(),
              _infoTile("Contact Number", contactNumber),
              _divider(),
              _infoTile("Created At", createdAt),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // ================= ACTION BUTTONS =================
        Row(
          children: [
            // UPDATE BUTTON (MAROON PRIMARY)
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () =>
                      _openFormModal(context, isUpdate: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maroon,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // DELETE BUTTON (MAROON OUTLINE)
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Confirm Deletion",
                      middleText:
                          "Are you sure you want to delete this application?",
                      textCancel: "No",
                      textConfirm: "Yes",
                      confirmTextColor: Colors.white,
                      buttonColor: maroon,
                      onConfirm: () {
                        _deleteApplication();
                        Get.back();
                      },
                      onCancel: () => Get.back(),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: maroon,
                    side: const BorderSide(color: maroon),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
          
      ],
    ),
  );
}

 Widget _infoTile(String title, String value) {
  const Color maroon = Color(0xFF800000);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: maroon,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _divider() => Divider(color: const Color(0xFF800000).withOpacity(0.15));

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.insert_drive_file_outlined,
            size: 140,
            color: Color(0xFF800000),
          ),
          const SizedBox(height: 16),
          const Text(
            'No application applied',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _openFormModal(context),
            child:  Text('Add Application',style: TextStyle(fontSize: 16,color: Color(0xFFF4F6FB)),),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF800000),
                minimumSize: const Size(150, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
          ),
        ],
      ),
    );
  }

  void _openFormModal(BuildContext context, {bool isUpdate = false}) {
    // Prefill if update
    if (isUpdate) {
      locationCtrl.text = controller.box.read('location') ?? '';
      salaryCtrl.text = controller.box.read('salary') ?? '';
      experienceCtrl.text = controller.box.read('experience') ?? '';
      workingHoursCtrl.text = controller.box.read('working_hours') ?? '';
      contactCtrl.text = controller.box.read('contact_number') ?? '';
      createdAtCtrl.text = controller.box.read('created_at') ?? '';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _inputField('Location', controller.locationcontroller),
                _inputField('Salary', controller.salarycontroller),
                _inputField('Experience', controller.experiencecontroller),
                _inputField('Working Hours', controller.workingcontroller),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    controller.UploadUserApplication(); // FIXED
                  },
                  child: const Text('Confirm', style: TextStyle(fontSize: 16,color: Color(0xFFF4F6FB)),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF800000),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteApplication() {
    controller.box.remove('location');
    controller.box.remove('salary');
    controller.box.remove('experience');
    controller.box.remove('working_hours');
    controller.box.remove('contact_number');
    controller.box.remove('created_at');

    Get.offAll(Applicationpage());
  }

  Widget _inputField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    const Color maroon = Color(0xFF800000);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        cursorColor: maroon,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),

        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),

          prefixIcon: icon != null ? Icon(icon, color: maroon, size: 20) : null,

          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: maroon, width: 1.5),
          ),

          // subtle shadow effect via border background contrast
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
