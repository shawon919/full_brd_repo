import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:brd/admin-portion/Admin-templates/Driverlist.dart';
import 'package:brd/admin-portion/AdmingetXcontroller/AdmingetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Driverapplicationview extends StatelessWidget {
  Driverapplicationview({super.key});

  final Admingetxcontroller admingetxcontroller =
      Get.put(Admingetxcontroller());

  final Usergetxcontroller controller =
      Get.put(Usergetxcontroller());

  // ============================================================
  // ADMIN DASHBOARD COLORS
  // ============================================================

  static const Color maroon =
      Color(0xFF4F46E5);

  static const Color maroonDark =
      Color(0xFF312E81);

  static const Color surface =
      Color(0xFFF5F7FB);

  static const Color ink =
      Color(0xFF172033);

  static const Color sub =
      Color(0xFF64748B);

  static const Color line =
      Color(0xFFE5E7EB);

  // ============================================================
  // STATIC ADMIN PASSWORD
  // ============================================================

  static const String adminPassword = "admin";

  // ============================================================
  // DOCUMENT IMAGE CARD
  // ============================================================

  Widget buildImageCard(
    String title,
    String image,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: line,
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 12,
            offset:
                const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(
              top: Radius.circular(16),
            ),

            child: AspectRatio(
              aspectRatio: 16 / 10,

              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,

                      loadingBuilder:
                          (context, child,
                              progress) {
                        if (progress ==
                            null) {
                          return child;
                        }

                        return const Center(
                          child:
                              CircularProgressIndicator(
                            color: maroon,
                          ),
                        );
                      },

                      errorBuilder:
                          (context, error,
                              stackTrace) {
                        return Container(
                          color: surface,

                          child:
                              const Center(
                            child: Icon(
                              Icons
                                  .broken_image_outlined,
                              color: sub,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child:
                          CircularProgressIndicator(
                        color: maroon,
                      ),
                    ),
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),

            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,

                  decoration:
                      const BoxDecoration(
                    color: maroon,
                    shape:
                        BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    title,

                    style:
                        const TextStyle(
                      color: ink,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w600,
                    ),
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
  // INFORMATION TILE
  // ============================================================

  Widget buildInfoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: line,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.03,
            ),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color:
                  maroon.withOpacity(
                0.08,
              ),

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Icon(
              icon,
              color: maroon,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  title,

                  style:
                      const TextStyle(
                    color: sub,
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(
                    color: ink,
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w700,
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
  // ADMIN PASSWORD DIALOG
  // ============================================================

  void showApprovePasswordDialog(
      BuildContext context) {
    final TextEditingController
        passwordController =
        TextEditingController();

    bool obscurePassword = true;

    Get.dialog(
      StatefulBuilder(
        builder:
            (context, setState) {
          return AlertDialog(
            backgroundColor:
                Colors.white,

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            title: const Text(
              "Admin Verification",

              style: TextStyle(
                color: ink,
                fontSize: 18,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            content: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                const Text(
                  "Enter the admin password to approve this driver.",

                  style: TextStyle(
                    color: sub,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                TextField(
                  controller:
                      passwordController,

                  obscureText:
                      obscurePassword,

                  autofocus: true,

                  style:
                      const TextStyle(
                    color: ink,
                  ),

                  decoration:
                      InputDecoration(
                    labelText:
                        "Admin Password",

                    labelStyle:
                        const TextStyle(
                      color: sub,
                    ),

                    prefixIcon:
                        const Icon(
                      Icons
                          .lock_outline,
                      color: maroon,
                    ),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons
                                .visibility_outlined
                            : Icons
                                .visibility_off_outlined,

                        color: sub,
                      ),

                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },
                    ),

                    filled: true,

                    fillColor:
                        surface,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      borderSide:
                          const BorderSide(
                        color: line,
                      ),
                    ),

                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      borderSide:
                          const BorderSide(
                        color: line,
                      ),
                    ),

                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      borderSide:
                          const BorderSide(
                        color: maroon,
                        width: 1.5,
                      ),
                    ),
                  ),

                  onSubmitted: (_) {
                    _confirmDriverApproval(
                      passwordController
                          .text,
                    );
                  },
                ),
              ],
            ),

            actionsPadding:
                const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },

                child: const Text(
                  "Cancel",

                  style: TextStyle(
                    color: sub,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  _confirmDriverApproval(
                    passwordController
                        .text,
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      maroon,

                  foregroundColor:
                      Colors.white,

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      10,
                    ),
                  ),
                ),

                child: const Text(
                  "Confirm",
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // CONFIRM ADMIN PASSWORD
  // ============================================================

  void _confirmDriverApproval(
      String password) {
    if (password != adminPassword) {
      Get.snackbar(
        "Incorrect Password",
        "The admin password is incorrect.",

        snackPosition:
            SnackPosition.BOTTOM,

        backgroundColor:
            Colors.redAccent,

        colorText:
            Colors.white,

        margin:
            const EdgeInsets.all(12),

        borderRadius: 10,

        duration:
            const Duration(
          seconds: 2,
        ),
      );

      return;
    }

    // Close password dialog
    Get.back();

    // Approve driver
    admingetxcontroller
        .DriverApproveFunction(
      admingetxcontroller
          .driverId
          .value,
    );

    // Go back to driver list
    Get.off(
      Driverlist(),
    );
  }

  // ============================================================
  // MAIN UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,

      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(110),

        child: Container(
          decoration:
              const BoxDecoration(
            gradient:
                LinearGradient(
              begin:
                  Alignment.topLeft,

              end:
                  Alignment.bottomRight,

              colors: [
                maroon,
                maroonDark,
              ],
            ),
          ),

          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                14,
              ),

              child: Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(
                      Icons.arrow_back,
                      color:
                          Colors.white,
                    ),

                    onPressed: () =>
                        Get.back(),
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  const Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        Text(
                          "Driver Application",

                          style:
                              TextStyle(
                            color:
                                Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .w700,
                          ),
                        ),

                        SizedBox(
                          height: 3,
                        ),

                        Text(
                          "Review submitted verification documents",

                          style:
                              TextStyle(
                            color: Colors
                                .white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Obx(() {
        return SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            30,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              // ==================================================
              // PROFILE CARD
              // ==================================================

              Container(
                padding:
                    const EdgeInsets.all(
                  18,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius
                          .circular(
                    18,
                  ),

                  border:
                      Border.all(
                    color: line,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors
                          .black
                          .withOpacity(
                        0.04,
                      ),

                      blurRadius:
                          14,

                      offset:
                          const Offset(
                        0,
                        5,
                      ),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,

                      decoration:
                          BoxDecoration(
                        gradient:
                            const LinearGradient(
                          colors: [
                            maroon,
                            maroonDark,
                          ],
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                          16,
                        ),
                      ),

                      alignment:
                          Alignment
                              .center,

                      child: Text(
                        admingetxcontroller
                                .fullname
                                .value
                                .isNotEmpty
                            ? admingetxcontroller
                                .fullname
                                .value[0]
                                .toUpperCase()
                            : "D",

                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize: 22,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 16,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Text(
                            admingetxcontroller
                                .fullname
                                .value,

                            style:
                                const TextStyle(
                              color: ink,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight
                                      .w700,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(
                            admingetxcontroller
                                .email
                                .value,

                            style:
                                const TextStyle(
                              color: sub,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          Text(
                            admingetxcontroller
                                .mobile
                                .value,

                            style:
                                const TextStyle(
                              color: maroon,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // INFORMATION
              // ==================================================

              const Text(
                "Driver Information",

                style:
                    TextStyle(
                  color: ink,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              buildInfoTile(
                Icons.person_outline,
                "Full Name",
                admingetxcontroller
                    .fullname
                    .value,
              ),

              buildInfoTile(
                Icons.mail_outline,
                "Email Address",
                admingetxcontroller
                    .email
                    .value,
              ),

              buildInfoTile(
                Icons.phone_outlined,
                "Phone Number",
                admingetxcontroller
                    .mobile
                    .value,
              ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // DOCUMENTS
              // ==================================================

              const Text(
                "Verification Documents",

                style:
                    TextStyle(
                  color: ink,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              GridView.count(
                crossAxisCount: 2,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                crossAxisSpacing:
                    12,

                mainAxisSpacing:
                    12,

                childAspectRatio:
                    0.9,

                children: [
                  buildImageCard(
                    "NID Frontside",
                    admingetxcontroller
                        .NID_frontside
                        .value,
                  ),

                  buildImageCard(
                    "NID Backside",
                    admingetxcontroller
                        .NID_backside
                        .value,
                  ),

                  buildImageCard(
                    "DL Frontside",
                    admingetxcontroller
                        .DL_frontside
                        .value,
                  ),

                  buildImageCard(
                    "DL Backside",
                    admingetxcontroller
                        .DL_backside
                        .value,
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              // ==================================================
              // ACTION BUTTONS
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return SizedBox(
                        height: 52,

                        child:
                            ElevatedButton
                                .icon(
                          onPressed:
                              admingetxcontroller
                                      .is_loading
                                      .value
                                  ? null
                                  : () {
                                      showApprovePasswordDialog(
                                        context,
                                      );
                                    },

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                maroon,

                            foregroundColor:
                                Colors.white,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                14,
                              ),
                            ),

                            elevation: 0,
                          ),

                          icon: admingetxcontroller
                                  .is_loading
                                  .value
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,

                                  child:
                                      CircularProgressIndicator(
                                    color: Colors
                                        .white,
                                    strokeWidth:
                                        2,
                                  ),
                                )
                              : const Icon(
                                  Icons
                                      .check_circle_outline,
                                ),

                          label:
                              Text(
                            admingetxcontroller
                                    .is_loading
                                    .value
                                ? "Processing..."
                                : "Approve Driver",
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 52,

                      child:
                          OutlinedButton
                              .icon(
                        onPressed: () {},

                        style:
                            OutlinedButton
                                .styleFrom(
                          foregroundColor:
                              Colors.redAccent,

                          side:
                              const BorderSide(
                            color:
                                Colors.redAccent,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              14,
                            ),
                          ),
                        ),

                        icon:
                            const Icon(
                          Icons.close,
                        ),

                        label:
                            const Text(
                          "Reject",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}