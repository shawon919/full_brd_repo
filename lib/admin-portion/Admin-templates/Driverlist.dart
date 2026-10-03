import 'package:brd/admin-portion/Admin-templates/DriverApplicationView.dart';
import 'package:brd/admin-portion/AdmingetXcontroller/AdmingetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Driverlist extends StatelessWidget {
  Driverlist({super.key});

  final Admingetxcontroller admingetxcontroller =
      Get.put(Admingetxcontroller());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,

      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(110),

        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        Get.back(),
                  ),

                  const SizedBox(width: 6),

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
                          "Driver Applications",

                          style: TextStyle(
                            color:
                                Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .w700,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          "Review pending driver requests",

                          style: TextStyle(
                            color: Colors
                                .white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Obx(() {
                    return Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),

                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(
                                0.18),

                        borderRadius:
                            BorderRadius
                                .circular(
                                    20),
                      ),

                      child: Text(
                        "${admingetxcontroller.driverList.length}",

                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Obx(() {
        /// LOADING
        if (admingetxcontroller
            .is_loading.value) {
          return const Center(
            child:
                CircularProgressIndicator(
              color: maroon,
            ),
          );
        }

        /// EMPTY
        if (admingetxcontroller
            .driverList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [
                Container(
                  padding:
                      const EdgeInsets.all(
                          20),

                  decoration: BoxDecoration(
                    color:
                        maroon.withOpacity(
                            0.08),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons
                        .person_off_outlined,
                    color: maroon,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "No Applications Found",

                  style: TextStyle(
                    color: ink,
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "New driver requests will appear here",

                  style: TextStyle(
                    color: sub,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        /// LIST
        return ListView.builder(
          padding:
              const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            24,
          ),

          itemCount:
              admingetxcontroller
                  .driverList.length,

          itemBuilder:
              (context, index) {
            final driver =
                admingetxcontroller
                    .driverList[index];

            return UserCard(
              username:
                  driver['FullName'] ??
                      '',

              email:
                  driver['email'] ?? '',

              onViewPressed: () {
                admingetxcontroller
                    .fetchdriverprofile(
                  driver['id'],
                );

                Get.to(
                  () =>
                      Driverapplicationview(),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class UserCard extends StatelessWidget {
  final String username;
  final String email;
  final VoidCallback onViewPressed;

  const UserCard({
    super.key,
    required this.username,
    required this.email,
    required this.onViewPressed,
  });

  static const Color maroon =
      Color(0xFF4F46E5);

  static const Color maroonDark =
      Color(0xFF312E81);

  static const Color ink =
      Color(0xFF172033);

  static const Color sub =
      Color(0xFF64748B);

  static const Color line =
      Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),

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
                    0.03),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(14),

        child: Row(
          children: [
            /// AVATAR
            Container(
              width: 52,
              height: 52,

              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    maroon,
                    maroonDark,
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              alignment: Alignment.center,

              child: Text(
                username.isNotEmpty
                    ? username[0]
                        .toUpperCase()
                    : "D",

                style: const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// INFO
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    username,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(
                      color: ink,
                      fontSize: 15,
                      fontWeight:
                          FontWeight
                              .w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    email.isNotEmpty
                        ? email
                        : "No email provided",

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(
                      color: sub,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),

                    decoration:
                        BoxDecoration(
                      color: Colors.orange
                          .withOpacity(
                              0.12),

                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),

                    child: const Text(
                      "Pending Review",

                      style: TextStyle(
                        color:
                            Colors.orange,
                        fontSize: 11,
                        fontWeight:
                            FontWeight
                                .w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// BUTTON
            SizedBox(
              height: 42,

              child: ElevatedButton.icon(
                onPressed:
                    onViewPressed,

                style: ElevatedButton
                    .styleFrom(
                  backgroundColor:
                      maroon,

                  foregroundColor:
                      Colors.white,

                  elevation: 0,

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 14,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                                12),
                  ),
                ),

                icon: const Icon(
                  Icons
                      .visibility_outlined,
                  size: 18,
                ),

                label: const Text(
                  "View",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}