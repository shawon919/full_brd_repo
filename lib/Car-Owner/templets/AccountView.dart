import 'package:brd/Car-Owner/templets/UserProfile.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';




class Accountview extends StatelessWidget {
  Accountview({super.key});

  static const Color maroon = Color(0xFF800000);

  final Usergetxcontroller controller = Get.put(Usergetxcontroller());

  bool get hasProfile =>
      controller.profilePicture.value.isNotEmpty ||
      controller.bio.value.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final email = controller.box.read("email") ?? "";
    final fullName = controller.box.read("fullName") ?? "";
    final phoneNumber = controller.box.read("phone") ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: maroon,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          Obx(() {
            final showEdit =
                controller.profilePicture.value.isNotEmpty &&
                controller.bio.value.isNotEmpty;

            return showEdit
                ? IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => showUpdateProfileModal(context),
                  )
                : const SizedBox();
          }),
        ],
      ),

      // ================= BODY =================
      body: Obx(() {
        if (controller.profileloading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 10),

              _ProfileCard(),

              const SizedBox(height: 16),

              _InfoCard(
                fullName: fullName,
                email: email,
                phone: phoneNumber,
              ),

              const SizedBox(height: 20),

              _ActionSection(context),

              const SizedBox(height: 20),
              Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: maroon),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Keep your account secure by updating settings regularly.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        );
      }),
    );
  }

  Widget _ActionSection(BuildContext context) {
    return Obx(() {
      final hasProfile =
          controller.profilePicture.value.isNotEmpty ||
          controller.bio.value.isNotEmpty;

      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => showEditProfileModal(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: maroon,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
              ),
              child: Text(
                hasProfile ? "Edit Profile" : "",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () => showDeleteDialog(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text("Delete Account"),
            ),
          ),
        ],
      );
    });
  }
}

// ================= PROFILE CARD =================
class _ProfileCard extends StatelessWidget {
  final Usergetxcontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final image = controller.box.read("profilePicture") ?? "";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF800000).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Obx(() {
            final img = controller.profilePicture.value;

            return CircleAvatar(
              radius: 34,
              backgroundColor: const Color(0xFFF3F4F6),
              backgroundImage: img.isNotEmpty
                  ? NetworkImage(img)
                  : (image.isNotEmpty ? NetworkImage(image) : null),
              child: img.isEmpty && image.isEmpty
                  ? const Icon(Icons.person, size: 32, color: Colors.grey)
                  : null,
            );
          }),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.box.read("fullName") ?? "User",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.box.read("email") ?? "",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= INFO CARD =================
class _InfoCard extends StatelessWidget {
  final String fullName;
  final String email;
  final String phone;

  const _InfoCard({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _tile("Name", fullName),
          _divider(),
          _tile("Email", email),
          _divider(),
          _tile("Phone", phone),
          _divider(),
          _tile(
            "Address",
            Get.find<Usergetxcontroller>().box.read('bio') ?? "",
          ),
        ],
      ),
    );
  }

  Widget _tile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1);
}

// ================= DELETE DIALOG =================
void showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text("Delete Account"),
      content: const Text("Are you sure you want to delete your account?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}




void showEditProfileModal(BuildContext context) {
  final Usergetxcontroller controller = Get.put(Usergetxcontroller());
  String userProfile = controller.box.read("profilePicture") ?? "";

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // ================= PROFILE IMAGE =================
                  Obx(() {
                    if (controller.profileloading.value) {
                      return const CircularProgressIndicator();
                    }

                    return SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                controller.profileImage.value != null
                                    ? FileImage(controller.profileImage.value!)
                                    : NetworkImage(userProfile),
                          ),

                          Positioned(
                            right: -10,
                            bottom: 0,
                            child: TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Change Profile Picture",
                                  content: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          controller.subfunction('chose from gallery');
                                          Get.back();
                                        },
                                        child: const Text("Gallery"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.subfunction('take a photo');
                                          Get.back();
                                        },
                                        child: const Text("Camera"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  TextField(
                    controller: controller.user_bio,
                    decoration: const InputDecoration(
                      hintText: "Address",
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateUserProfile();
                        Navigator.pop(context);
                      },
                      child: const Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

}




void showUpdateProfileModal(BuildContext context) {
  final Usergetxcontroller controller = Get.put(Usergetxcontroller());
  String userProfile = controller.box.read("profilePicture") ?? "";

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  const Text(
                    "Add Profile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  Obx(() {
                    if (controller.profileloading.value) {
                      return const CircularProgressIndicator();
                    }

                    return SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                controller.profileImage.value != null
                                    ? FileImage(controller.profileImage.value!)
                                    : NetworkImage(userProfile),
                          ),

                          Positioned(
                            right: -10,
                            bottom: 0,
                            child: TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Change Profile Picture",
                                  content: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          controller.subfunction('chose from gallery');
                                          Get.back();
                                        },
                                        child: const Text("Gallery"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.subfunction('take a photo');
                                          Get.back();
                                        },
                                        child: const Text("Camera"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  TextField(
                    controller: controller.bioController,
                    decoration: const InputDecoration(
                      hintText: "Address",
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      controller.uploadUserProfile(
                        controller.bioController.text,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Save Changes"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}