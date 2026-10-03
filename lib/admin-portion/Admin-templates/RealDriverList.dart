import 'package:brd/admin-portion/AdmingetXcontroller/AdmingetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Realdriverlist extends StatelessWidget {
  Realdriverlist({super.key});

  final Admingetxcontroller controller = Get.put(Admingetxcontroller());

  // ============================================================
  // SAME UI COLORS AS ADMIN DASHBOARD
  // ============================================================

  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryDark = Color(0xFF312E81);
  static const Color surface = Color(0xFFF7F7F9);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color sub = Color(0xFF6B7280);
  static const Color line = Color(0xFFE5E7EB);

  static const String baseURL =
      'https://nonideologically-minuscular-hoyt.ngrok-free.dev';

  String _img(String? path) => path == null ? '' : "$baseURL$path";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),

        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primary,
                primaryDark,
              ],
            ),
          ),

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                12,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),

                        onPressed: () => Get.back(),
                      ),

                      const SizedBox(width: 4),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Driver Directory",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),

                            Text(
                              "Verified partners on the platform",

                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Obx(
                        () => Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.18),

                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: Text(
                            "${controller.drivers.length}",

                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Container(
                    height: 44,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(12),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.08),

                          blurRadius: 12,

                          offset:
                              const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: TextField(
                      controller:
                          controller.searchController,

                      onChanged: (value) =>
                          controller.searchDriver(),

                      style: const TextStyle(
                        color: ink,
                        fontSize: 14,
                      ),

                      decoration:
                          InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 8,
                        ),

                        hintText:
                            "Search name, phone, email",

                        hintStyle:
                            const TextStyle(
                          color: sub,
                          fontSize: 13,
                        ),

                        prefixIcon:
                            const Icon(
                          Icons.search,
                          color: primary,
                        ),

                        suffixIcon:
                            IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: sub,
                          ),

                          onPressed: () =>
                              controller.clearSearch(),
                        ),

                        border:
                            InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          );
        }

        if (controller.drivers.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                Container(
                  padding:
                      const EdgeInsets.all(20),

                  decoration:
                      BoxDecoration(
                    color: primary
                        .withOpacity(0.08),

                    shape:
                        BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.person_off_outlined,
                    color: primary,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "No Drivers Found",

                  style: TextStyle(
                    color: ink,
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Try adjusting your search filters",

                  style: TextStyle(
                    color: sub,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount:
              controller.drivers.length,

          padding:
              const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            24,
          ),

          itemBuilder:
              (context, index) {

            final driver =
                controller.drivers[index];

            final user =
                driver['user'];

            return Obx(() {

              final isExpanded =
                  controller.expandedIndex.value ==
                      index;

              return _driverCard(
                driver,
                user,
                index,
                isExpanded,
              );
            });
          },
        );
      }),
    );
  }

  Widget _driverCard(
    dynamic driver,
    dynamic user,
    int index,
    bool isExpanded,
  ) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 200),

      margin:
          const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: isExpanded
              ? primary.withOpacity(0.4)
              : line,

          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              isExpanded ? 0.06 : 0.03,
            ),

            blurRadius: 14,

            offset:
                const Offset(0, 6),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius:
              BorderRadius.circular(16),

          onTap: () =>
              controller.toggleExpand(index),

          child: Padding(
            padding:
                const EdgeInsets.all(14),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(
                  children: [

                    Container(
                      width: 44,
                      height: 44,

                      decoration:
                          BoxDecoration(
                        gradient:
                            const LinearGradient(
                          colors: [
                            primary,
                            primaryDark,
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      alignment:
                          Alignment.center,

                      child: Text(
                        ((user?['fullName'] ??
                                        'D')
                                    .toString()
                                    .isNotEmpty
                                ? user['fullName']
                                    .toString()[0]
                                : 'D')
                            .toUpperCase(),

                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            user?['fullName'] ??
                                "No Name",

                            style:
                                const TextStyle(
                              color: ink,
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            user?['email'] ??
                                '—',

                            maxLines: 1,

                            overflow:
                                TextOverflow.ellipsis,

                            style:
                                const TextStyle(
                              color: sub,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.all(6),

                      decoration:
                          BoxDecoration(
                        color: surface,

                        shape:
                            BoxShape.circle,
                      ),

                      child: Icon(
                        isExpanded
                            ? Icons
                                .keyboard_arrow_up_rounded
                            : Icons
                                .keyboard_arrow_down_rounded,

                        color: primary,
                      ),
                    ),
                  ],
                ),

                if (isExpanded) ...[
                  const SizedBox(height: 14),

                  const Divider(
                    height: 1,
                    color: line,
                  ),

                  const SizedBox(height: 14),

                  _infoRow(
                    Icons.mail_outline,
                    "Email",
                    user?['email'] ?? '—',
                  ),

                  const SizedBox(height: 8),

                  _infoRow(
                    Icons.phone_outlined,
                    "Phone",
                    user?['phone'] ?? '—',
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [

                      Container(
                        width: 4,
                        height: 14,

                        decoration:
                            BoxDecoration(
                          color: primary,

                          borderRadius:
                              BorderRadius.circular(2),
                        ),
                      ),

                      const SizedBox(width: 8),

                      const Text(
                        "VERIFICATION DOCUMENTS",

                        style: TextStyle(
                          color: ink,
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 2,

                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisSpacing: 10,

                    mainAxisSpacing: 10,

                    childAspectRatio: 0.95,

                    children: [

                      buildImageCard(
                        "DL Front",
                        _img(
                          driver[
                              'DL_frontside'],
                        ),
                      ),

                      buildImageCard(
                        "DL Back",
                        _img(
                          driver[
                              'DL_Backside'],
                        ),
                      ),

                      buildImageCard(
                        "NID Front",
                        _img(
                          driver[
                              'NID_frontside'],
                        ),
                      ),

                      buildImageCard(
                        "NID Back",
                        _img(
                          driver[
                              'NID_backside'],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  buildImageCard(
                    "Curriculum Vitae",
                    _img(
                      driver['CV_field'],
                    ),

                    fullWidth: true,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [

        Container(
          padding:
              const EdgeInsets.all(8),

          decoration:
              BoxDecoration(
            color: primary
                .withOpacity(0.08),

            borderRadius:
                BorderRadius.circular(8),
          ),

          child: Icon(
            icon,
            color: primary,
            size: 16,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          label,

          style:
              const TextStyle(
            color: sub,
            fontSize: 12,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            value,

            textAlign:
                TextAlign.right,

            overflow:
                TextOverflow.ellipsis,

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
    );
  }
}

Widget buildImageCard(
  String title,
  String url, {
  bool fullWidth = false,
}) {
  const Color primary =
      Color(0xFF4F46E5);

  const Color line =
      Color(0xFFE5E7EB);

  const Color ink =
      Color(0xFF1A1A1A);

  return Container(
    decoration:
        BoxDecoration(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(12),

      border:
          Border.all(
        color: line,
      ),
    ),

    clipBehavior:
        Clip.antiAlias,

    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,

      children: [

        AspectRatio(
          aspectRatio:
              fullWidth ? 16 / 7 : 4 / 3,

          child: url.isEmpty
              ? const Center(
                  child:
                      CircularProgressIndicator(
                    color: primary,
                    strokeWidth: 2,
                  ),
                )

              : Image.network(
                  url,

                  fit: BoxFit.cover,

                  loadingBuilder:
                      (c, child, p) =>
                          p == null
                              ? child
                              : const Center(
                                  child:
                                      CircularProgressIndicator(
                                    color: primary,
                                    strokeWidth: 2,
                                  ),
                                ),

                  errorBuilder:
                      (c, e, s) =>
                          Container(
                    color:
                        const Color(
                            0xFFF7F7F9),

                    child: const Icon(
                      Icons
                          .broken_image_outlined,
                      size: 36,
                      color:
                          Color(0xFF6B7280),
                    ),
                  ),
                ),
        ),

        Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),

          child: Row(
            children: [

              Container(
                width: 6,
                height: 6,

                decoration:
                    const BoxDecoration(
                  color: primary,
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
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                  ),

                  overflow:
                      TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}