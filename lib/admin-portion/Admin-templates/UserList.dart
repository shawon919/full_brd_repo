import 'package:brd/admin-portion/AdmingetXcontroller/AdmingetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:brd/admin-portion/AdminApiHandler/userListModel.dart';
import 'package:brd/admin-portion/AdminApiHandler/AdminApiHandler.dart';
import 'package:brd/admin-portion/Admin-templates/UserProfileView.dart';

class Userlist extends StatelessWidget {
  Userlist({super.key});

  final Admingetxcontroller controller =
      Get.find<Admingetxcontroller>();

  final Adminapihandler apiHandler =
      Adminapihandler();

  // ---------------------------------------------------------
  // VIEW USER PROFILE
  // ---------------------------------------------------------

  Future<void> _viewUserProfile(int userId) async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF800000),
          ),
        ),
        barrierDismissible: false,
      );

      final Map<String, dynamic> userData =
          await apiHandler.fetchUserProfile(userId);

      if (Get.isDialogOpen == true) {
        Get.back();
      }

      print("User profile data: $userData");

      Get.to(
        () => UserProfileView(
          userData: userData,
        ),
      );
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      print("View user error: $e");

      Get.snackbar(
        "Error",
        "Unable to load user profile",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    }
  }

  // ---------------------------------------------------------
  // TERMINATE USER - ADMIN PASSWORD DIALOG
  // ---------------------------------------------------------

  void _showTerminateDialog(
    int userId,
    String userName,
  ) {
    final TextEditingController passwordController =
        TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Terminate User",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You are about to terminate:",
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Admin Password",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter admin password",
                prefixIcon: const Icon(
                  Icons.lock_outline,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(
                    color: Color(0xFF800000),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final String password =
                  passwordController.text.trim();

              if (password.isEmpty) {
                Get.snackbar(
                  "Required",
                  "Admin password is required",
                  snackPosition:
                      SnackPosition.BOTTOM,
                  backgroundColor:
                      Colors.red,
                  colorText:
                      Colors.white,
                );

                return;
              }

              Get.back();

              _showFinalTerminateConfirmation(
                userId,
                userName,
                password,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              "Continue",
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // FINAL TERMINATION CONFIRMATION
  // ---------------------------------------------------------

  void _showFinalTerminateConfirmation(
    int userId,
    String userName,
    String password,
  ) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Confirm Termination",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to terminate "
          "$userName?\n\n"
          "This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();

              await _terminateUser(
                userId,
                userName,
                password,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              "Terminate",
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // DIRECT TERMINATE API CALL
  // ---------------------------------------------------------

  Future<void> _terminateUser(
    int userId,
    String userName,
    String password,
  ) async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF800000),
          ),
        ),
        barrierDismissible: false,
      );

      final Map<String, dynamic> response =
          await apiHandler.terminateUser(
        userId,
        password,
      );

      if (Get.isDialogOpen == true) {
        Get.back();
      }

      print(
        "Terminate response: $response",
      );

      controller.user.removeWhere(
        (user) => user.id == userId,
      );

      Get.snackbar(
        "Success",
        response['message'] ??
            "User terminated successfully",
        snackPosition:
            SnackPosition.BOTTOM,
        backgroundColor:
            const Color(0xFF800000),
        colorText:
            Colors.white,
        margin:
            const EdgeInsets.all(15),
      );
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      print(
        "Terminate user error: $e",
      );

      Get.snackbar(
        "Error",
        e.toString().replaceFirst(
              "Exception: ",
              "",
            ),
        snackPosition:
            SnackPosition.BOTTOM,
        backgroundColor:
            Colors.red,
        colorText:
            Colors.white,
        margin:
            const EdgeInsets.all(15),
      );
    }
  }

  // ---------------------------------------------------------
  // USER CARD
  // ---------------------------------------------------------

  Widget _userCard(
    Userlistmodel user,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 14),
      padding:
          const EdgeInsets.all(18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
        border:
            Border.all(
          color:
              const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFF7EAEA),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child:
                const Icon(
              Icons.person,
              color:
                  Color(0xFF800000),
              size: 28,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF172033),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 13,
                    color:
                        Color(0xFF64748B),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  user.phone,
                  style:
                      const TextStyle(
                    fontSize: 13,
                    color:
                        Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            tooltip:
                "View User",
            onPressed: () {
              _viewUserProfile(
                user.id,
              );
            },
            icon:
                const Icon(
              Icons.visibility_outlined,
              color:
                  Color(0xFF800000),
            ),
          ),
          IconButton(
            tooltip:
                "Terminate User",
            onPressed: () {
              _showTerminateDialog(
                user.id,
                user.fullName,
              );
            },
            icon:
                const Icon(
              Icons.delete_outline,
              color:
                  Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),

      body: SafeArea(
        child: Column(
          children: [

            // -------------------------------------------------
            // HEADER + BACK BUTTON
            // -------------------------------------------------

            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                10,
              ),

              child: Row(
                children: [

                  // BACK BUTTON
                  Container(
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                      border:
                          Border.all(
                        color:
                            const Color(
                          0xFFE5E7EB,
                        ),
                      ),
                    ),

                    child: IconButton(
                      tooltip:
                          "Back to Dashboard",

                      icon:
                          const Icon(
                        Icons
                            .arrow_back_rounded,
                        color:
                            Color(0xFF800000),
                      ),

                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),

                  const SizedBox(
                    width: 14,
                  ),

                  const Expanded(
                    child:
                        Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Users",
                          style:
                              TextStyle(
                            fontSize: 26,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Color(0xFF172033),
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Text(
                          "Manage registered users",
                          style:
                              TextStyle(
                            fontSize: 14,
                            color:
                                Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Obx(() {
                    final int userCount =
                        controller.user.length;

                    return Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFFF7EAEA,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                      child:
                          Column(
                        children: [

                          Text(
                            userCount.toString(),
                            style:
                                const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF800000),
                            ),
                          ),

                          const Text(
                            "Users",
                            style:
                                TextStyle(
                              fontSize: 11,
                              color:
                                  Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),

              child:
                  TextField(
                controller:
                    controller
                        .usersearchController,

                onChanged: (value) {
                  controller.searchUser();
                },

                decoration:
                    InputDecoration(
                  hintText:
                      "Search by name, email or phone",

                  prefixIcon:
                      const Icon(
                    Icons.search,
                    color:
                        Color(0xFF64748B),
                  ),

                  filled:
                      true,

                  fillColor:
                      Colors.white,

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide:
                        BorderSide.none,
                  ),

                  enabledBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(
                      color:
                          Color(0xFFE5E7EB),
                    ),
                  ),

                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(
                      color:
                          Color(0xFF800000),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child:
                  Obx(() {

                if (controller
                    .is_loading.value) {
                  return const Center(
                    child:
                        CircularProgressIndicator(
                      color:
                          Color(0xFF800000),
                    ),
                  );
                }

                if (controller.user.isEmpty) {
                  return const Center(
                    child:
                        Column(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [

                        Icon(
                          Icons.people_outline,
                          size: 60,
                          color:
                              Color(0xFF94A3B8),
                        ),

                        SizedBox(
                          height: 12,
                        ),

                        Text(
                          "No users found",
                          style:
                              TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.w600,
                            color:
                                Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets
                          .fromLTRB(
                    20,
                    10,
                    20,
                    20,
                  ),

                  itemCount:
                      controller.user.length,

                  itemBuilder:
                      (context, index) {

                    final Userlistmodel user =
                        controller.user[index];

                    return _userCard(
                      user,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}