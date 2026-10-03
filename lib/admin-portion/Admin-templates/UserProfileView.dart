import 'package:brd/admin-portion/AdminApiHandler/AdminApiHandler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({
    required this.userData,
    super.key,
  });

  // ============================================================
  // API RESPONSE
  // ============================================================

  final Map<String, dynamic> userData;

  // ============================================================
  // DIRECT API HANDLER
  // ============================================================

  final Adminapihandler apiHandler =
      Adminapihandler();

  @override
  Widget build(BuildContext context) {

    const Color primary =
        Color(0xFF4F46E5);

    const Color primaryDark =
        Color(0xFF312E81);

    const Color pageBackground =
        Color(0xFFF5F7FB);

    const Color textDark =
        Color(0xFF172033);

    const Color textGrey =
        Color(0xFF64748B);

    // ============================================================
    // DIRECT API RESPONSE
    // ============================================================

    final Map<String, dynamic> user =
        userData;

    return Scaffold(
      backgroundColor:
          pageBackground,

      appBar: AppBar(
        backgroundColor:
            Colors.white,

        elevation: 0,

        leading:
            IconButton(
          onPressed: () {
            Get.back();
          },

          icon:
              const Icon(
            Icons.arrow_back,
            color: textDark,
          ),
        ),

        title:
            const Text(
          "User Profile",

          style:
              TextStyle(
            color: textDark,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),

      // ==========================================================
      // SHOW API RESPONSE DIRECTLY
      // ==========================================================

      body: user.isEmpty
          ? const Center(
              child:
                  Text(
                "User information not found",

                style:
                    TextStyle(
                  color: textGrey,
                ),
              ),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                18,
              ),

              child: Column(
                children: [

                  // ==================================================
                  // PROFILE HEADER
                  // ==================================================

                  Container(
                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.all(
                      22,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black
                                  .withOpacity(
                            0.05,
                          ),

                          blurRadius:
                              12,

                          offset:
                              const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [

                        Container(
                          width: 82,
                          height: 82,

                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFFEEF2FF,
                            ),

                            shape:
                                BoxShape.circle,
                          ),

                          child:
                              const Icon(
                            Icons.person,
                            size: 43,
                            color: primary,
                          ),
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        Text(
                          _value(
                            user,
                            "fullName",
                            "No Name",
                          ),

                          textAlign:
                              TextAlign.center,

                          style:
                              const TextStyle(
                            color:
                                textDark,

                            fontSize:
                                22,

                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          _value(
                            user,
                            "email",
                            "No email",
                          ),

                          textAlign:
                              TextAlign.center,

                          style:
                              const TextStyle(
                            color:
                                textGrey,

                            fontSize:
                                14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // ==================================================
                  // PERSONAL INFORMATION
                  // ==================================================

                  _sectionTitle(
                    "Personal Information",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _informationCard(
                    children: [

                      _informationRow(
                        icon:
                            Icons.badge_outlined,

                        title:
                            "User ID",

                        value:
                            _value(
                          user,
                          "id",
                          "N/A",
                        ),
                      ),

                      _divider(),

                      _informationRow(
                        icon:
                            Icons.person_outline,

                        title:
                            "Full Name",

                        value:
                            _value(
                          user,
                          "fullName",
                          "N/A",
                        ),
                      ),

                      _divider(),

                      _informationRow(
                        icon:
                            Icons.email_outlined,

                        title:
                            "Email",

                        value:
                            _value(
                          user,
                          "email",
                          "N/A",
                        ),
                      ),

                      _divider(),

                      _informationRow(
                        icon:
                            Icons.phone_outlined,

                        title:
                            "Phone",

                        value:
                            _value(
                          user,
                          "phone",
                          "N/A",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // ==================================================
                  // ACCOUNT INFORMATION
                  // ==================================================

                  _sectionTitle(
                    "Account Information",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _informationCard(
                    children: [

                      _statusRow(
                        icon:
                            Icons.verified_user_outlined,

                        title:
                            "Account Status",

                        value:
                            user["is_active"] ==
                                    true
                                ? "Active"
                                : "Inactive",

                        active:
                            user["is_active"] ==
                                true,
                      ),

                      _divider(),

                      _statusRow(
                        icon:
                            Icons.admin_panel_settings_outlined,

                        title:
                            "Admin",

                        value:
                            user["is_admin"] ==
                                    true
                                ? "Yes"
                                : "No",

                        active:
                            user["is_admin"] ==
                                true,
                      ),

                      _divider(),

                      _statusRow(
                        icon:
                            Icons.badge_outlined,

                        title:
                            "Staff",

                        value:
                            user["is_staff"] ==
                                    true
                                ? "Yes"
                                : "No",

                        active:
                            user["is_staff"] ==
                                true,
                      ),

                      _divider(),

                      _statusRow(
                        icon:
                            Icons.directions_car_outlined,

                        title:
                            "Driver",

                        value:
                            user["is_driver"] ==
                                    true
                                ? "Yes"
                                : "No",

                        active:
                            user["is_driver"] ==
                                true,
                      ),

                      _divider(),

                      _statusRow(
                        icon:
                            Icons.security_outlined,

                        title:
                            "Superuser",

                        value:
                            user["is_superuser"] ==
                                    true
                                ? "Yes"
                                : "No",

                        active:
                            user["is_superuser"] ==
                                true,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // ==================================================
                  // DATE INFORMATION
                  // ==================================================

                  _sectionTitle(
                    "Account Dates",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _informationCard(
                    children: [

                      _informationRow(
                        icon:
                            Icons.calendar_today_outlined,

                        title:
                            "Created At",

                        value:
                            _formatDate(
                          user["created_at"],
                        ),
                      ),

                      _divider(),

                      _informationRow(
                        icon:
                            Icons.update_outlined,

                        title:
                            "Updated At",

                        value:
                            _formatDate(
                          user["updated_at"],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // ==================================================
                  // TERMINATE BUTTON
                  // ==================================================

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        ElevatedButton.icon(
                      onPressed: () {

                        final int? id =
                            int.tryParse(
                          user["id"]
                              .toString(),
                        );

                        if (id == null) {
                          return;
                        }

                        _showTerminateDialog(
                          id,

                          _value(
                            user,
                            "fullName",
                            "this user",
                          ),
                        );
                      },

                      icon:
                          const Icon(
                        Icons.person_remove_outlined,
                      ),

                      label:
                          const Text(
                        "Terminate User",

                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            primaryDark,

                        foregroundColor:
                            Colors.white,

                        elevation:
                            0,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
    String title,
  ) {
    return Align(
      alignment:
          Alignment.centerLeft,

      child:
          Text(
        title,

        style:
            const TextStyle(
          fontSize:
              17,

          fontWeight:
              FontWeight.w700,

          color:
              Color(0xFF172033),
        ),
      ),
    );
  }

  // ============================================================
  // INFORMATION CARD
  // ============================================================

  Widget _informationCard({
    required List<Widget> children,
  }) {
    return Container(
      width:
          double.infinity,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),

      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black
                    .withOpacity(
              0.04,
            ),

            blurRadius:
                10,

            offset:
                const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child:
          Column(
        children:
            children,
      ),
    );
  }

  // ============================================================
  // INFORMATION ROW
  // ============================================================

  Widget _informationRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 13,
      ),

      child:
          Row(
        children: [

          Container(
            width: 40,
            height: 40,

            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFEEF2FF,
              ),

              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),

            child:
                Icon(
              icon,

              color:
                  const Color(
                0xFF4F46E5,
              ),

              size:
                  21,
            ),
          ),

          const SizedBox(
            width: 13,
          ),

          Expanded(
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF64748B,
                    ),

                    fontSize:
                        12,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  value,

                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF172033,
                    ),

                    fontSize:
                        15,

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS ROW
  // ============================================================

  Widget _statusRow({
    required IconData icon,
    required String title,
    required String value,
    required bool active,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 13,
      ),

      child:
          Row(
        children: [

          Container(
            width: 40,
            height: 40,

            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFEEF2FF,
              ),

              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),

            child:
                Icon(
              icon,

              color:
                  const Color(
                0xFF4F46E5,
              ),

              size:
                  21,
            ),
          ),

          const SizedBox(
            width: 13,
          ),

          Expanded(
            child:
                Text(
              title,

              style:
                  const TextStyle(
                color:
                    Color(
                  0xFF172033,
                ),

                fontSize:
                    15,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 6,
            ),

            decoration:
                BoxDecoration(
              color:
                  active
                      ? const Color(
                          0xFFEEF2FF,
                        )
                      : const Color(
                          0xFFF1F5F9,
                        ),

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child:
                Text(
              value,

              style:
                  TextStyle(
                color:
                    active
                        ? const Color(
                            0xFF312E81,
                          )
                        : const Color(
                            0xFF64748B,
                          ),

                fontSize:
                    12,

                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _divider() {
    return const Divider(
      height: 1,
      color:
          Color(0xFFE5E7EB),
    );
  }

  // ============================================================
  // VALUE HELPER
  // ============================================================

  String _value(
    Map<String, dynamic> user,
    String key,
    String fallback,
  ) {
    final value =
        user[key];

    if (value == null ||
        value.toString().trim().isEmpty) {
      return fallback;
    }

    return value.toString();
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(
    dynamic value,
  ) {
    if (value == null) {
      return "N/A";
    }

    final String text =
        value.toString();

    try {
      final DateTime date =
          DateTime.parse(text);

      return
          "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year} "
          "${date.hour.toString().padLeft(2, '0')}:"
          "${date.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return text;
    }
  }

  // ============================================================
  // TERMINATION DIALOG
  // ============================================================

  void _showTerminateDialog(
    int userId,
    String userName,
  ) {
    final TextEditingController
        passwordController =
        TextEditingController();

    final RxBool obscure =
        true.obs;

    Get.dialog(
      AlertDialog(
        backgroundColor:
            Colors.white,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        title:
            const Text(
          "Terminate User",

          style:
              TextStyle(
            fontWeight:
                FontWeight.w700,
          ),
        ),

        content:
            Column(
          mainAxisSize:
              MainAxisSize.min,

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              "Terminate $userName?",
            ),

            const SizedBox(
              height: 16,
            ),

            const Text(
              "Enter your admin password.",

              style:
                  TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Obx(
              () => TextField(
                controller:
                    passwordController,

                obscureText:
                    obscure.value,

                decoration:
                    InputDecoration(
                  hintText:
                      "Admin password",

                  prefixIcon:
                      const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon:
                      IconButton(
                    onPressed: () {
                      obscure.value =
                          !obscure.value;
                    },

                    icon:
                        Icon(
                      obscure.value
                          ? Icons
                              .visibility_outlined
                          : Icons
                              .visibility_off_outlined,
                    ),
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
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

            child:
                const Text(
              "Cancel",
            ),
          ),

          ElevatedButton(
            onPressed: () {

              final String password =
                  passwordController
                      .text
                      .trim();

              if (password.isEmpty) {
                Get.snackbar(
                  "Password Required",
                  "Enter your admin password",

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

              _confirmTermination(
                userId,
                userName,
                password,
              );
            },

            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(
                0xFF312E81,
              ),

              foregroundColor:
                  Colors.white,
            ),

            child:
                const Text(
              "Continue",
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONFIRM TERMINATION
  // ============================================================

  void _confirmTermination(
    int userId,
    String userName,
    String password,
  ) {
    Get.dialog(
      AlertDialog(
        title:
            const Text(
          "Confirm Termination",

          style:
              TextStyle(
            fontWeight:
                FontWeight.w700,
          ),
        ),

        content:
            Text(
          "Are you sure you want to terminate "
          "$userName?",
        ),

        actions: [

          TextButton(
            onPressed: () {
              Get.back();
            },

            child:
                const Text(
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

            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(
                0xFF312E81,
              ),

              foregroundColor:
                  Colors.white,
            ),

            child:
                const Text(
              "Terminate",
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIRECT TERMINATE API
  // ============================================================

  Future<void> _terminateUser(
    int userId,
    String userName,
    String password,
  ) async {
    try {
      Get.dialog(
        const Center(
          child:
              CircularProgressIndicator(
            color:
                Color(0xFF800000),
          ),
        ),

        barrierDismissible:
            false,
      );

      final Map<String, dynamic>
          response =
          await apiHandler
              .terminateUser(
        userId,
        password,
      );

      if (Get.isDialogOpen == true) {
        Get.back();
      }

      print(
        "Terminate response: $response",
      );

      Get.snackbar(
        "Success",

        response['message'] ??
            "User terminated successfully",

        snackPosition:
            SnackPosition.BOTTOM,

        backgroundColor:
            const Color(
          0xFF800000,
        ),

        colorText:
            Colors.white,

        margin:
            const EdgeInsets.all(
          15,
        ),
      );

      // Go back to user list
      Get.back();

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
            const EdgeInsets.all(
          15,
        ),
      );
    }
  }
}