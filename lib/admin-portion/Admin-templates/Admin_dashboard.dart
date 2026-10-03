import 'package:brd/Car-Owner/templets/UserAccountPage.dart';
import 'package:brd/Car-Owner/templets/UserProfile.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:brd/admin-portion/AdmingetXcontroller/AdmingetxController.dart';
import 'package:brd/admin-portion/Admin-templates/UserContactManagement.dart';
import 'package:brd/GETX/Routes/get_routes.dart';
import 'package:brd/hire_service/views/admin_salary_sections.dart';
import 'package:brd/hire_service/views/service_management_pages.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ============================================================
// COLORS
// ============================================================

const Color primary = Color(0xFF800000);
const Color primaryDark = Color(0xFF5C0000);
const Color primaryLight = Color(0xFFF9EAEA);

const Color pageBackground = Color(0xFFF7F7F9);
const Color textDark = Color(0xFF1A1A1A);
const Color textGrey = Color(0xFF6B7280);
const Color borderColor = Color(0xFFE5E7EB);


// ============================================================
// ADMIN DASHBOARD
// ============================================================

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});

  final Usergetxcontroller controller =
      Get.find<Usergetxcontroller>();

  final List<Widget> pages = [
    HomeScreen(),
    Userprofile(),
    Useraccountpage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: pageBackground,

      body: screenWidth >= 900
          ? _DesktopAdminLayout(
              controller: controller,
              pages: pages,
            )
          : Obx(
              () => pages[
                  controller.currentIndex.value],
            ),

      bottomNavigationBar: screenWidth < 900
          ? CustomNavBar()
          : null,
    );
  }
}


// ============================================================
// DESKTOP ADMIN LAYOUT
// ============================================================

class _DesktopAdminLayout extends StatelessWidget {
  final Usergetxcontroller controller;
  final List<Widget> pages;

  const _DesktopAdminLayout({
    required this.controller,
    required this.pages,
  });

  String getPageTitle() {
    switch (controller.currentIndex.value) {
      case 0:
        return "Dashboard";

      case 1:
        return "Profile";

      case 2:
        return "Settings";

      default:
        return "Dashboard";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // ====================================================
        // SIDEBAR
        // ====================================================

        Container(
          width: 255,
          color: Colors.white,
          child: Column(
            children: [

              const SizedBox(height: 24),

              const _BRDLogo(),

              const SizedBox(height: 35),

              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [

                      const _SidebarSectionTitle(
                        title: "MAIN MENU",
                      ),

                      const SizedBox(height: 8),

                      // DASHBOARD
                      _SidebarItem(
                        icon:
                            Icons.dashboard_rounded,
                        title: "Dashboard",
                        selected:
                            controller.currentIndex.value ==
                                0,
                        onTap: () {
                          controller.currentIndex.value =
                              0;

                          controller.box.write(
                            'currentIndex',
                            0,
                          );
                        },
                      ),

                      const SizedBox(height: 6),

                      // USERS
                      _SidebarItem(
                        icon:
                            Icons.people_alt_rounded,
                        title: "Users",
                        selected: false,
                        onTap: () {
                          final adminController =
                              Get.put(
                            Admingetxcontroller(),
                          );

                          if (!adminController
                              .isLoading
                              .value) {
                            adminController
                                .fetchUserList();
                          }
                        },
                      ),

                      const SizedBox(height: 6),

                      // DRIVERS
                      _SidebarItem(
                        icon:
                            Icons.local_taxi_rounded,
                        title: "Drivers",
                        selected: false,
                        onTap: () {
                          final adminController =
                              Get.put(
                            Admingetxcontroller(),
                          );

                          adminController
                              .loadDrivers();
                        },
                      ),

                      const SizedBox(height: 6),

                      // DRIVER REQUESTS
                      _SidebarItem(
                        icon:
                            Icons.assignment_rounded,
                        title: "Driver Requests",
                        selected: false,
                        onTap: () {
                          final adminController =
                              Get.put(
                            Admingetxcontroller(),
                          );

                          adminController
                              .fetchDriveList();
                        },
                      ),

                      const SizedBox(height: 25),

                      const _SidebarSectionTitle(
                        title: "MANAGEMENT",
                      ),

                      const SizedBox(height: 8),

                      // NOTIFICATIONS
                      _SidebarItem(
                        icon:
                            Icons.notifications_rounded,
                        title: "Notifications",
                        selected: false,
                        badge: "3",
                        onTap: () => Get.toNamed(Routers.ADMIN_NOTIFICATIONS),
                      ),

                      const SizedBox(height: 6),

                      // MESSAGES
                      _SidebarItem(
                        icon:
                            Icons.message_rounded,
                        title: "Messages",
                        selected: false,
                        onTap: () {
                          Get.to(
                            () =>
                                UserContactManagement(),
                          );
                        },
                      ),

                      const SizedBox(height: 6),

                      // HIRE MANAGEMENT
                      _SidebarItem(
                        icon: Icons.handshake_rounded,
                        title: "Create Hire",
                        selected: false,
                        onTap: () => Get.toNamed(Routers.ADMIN_INITIAL_HIRE),
                      ),

                      const SizedBox(height: 6),

                      _SidebarItem(
                        icon: Icons.receipt_long_rounded,
                        title: "Billing & Transactions",
                        selected: false,
                        onTap: () => Get.toNamed(Routers.ADMIN_BILLING),
                      ),

                      const SizedBox(height: 6),
                      _SidebarItem(icon: Icons.directions_car_filled_rounded, title: "Active Services", selected: false, onTap: () => Get.to(() => const AdminActiveServicesPage())),
                      const SizedBox(height: 6),
                      _SidebarItem(icon: Icons.location_on_outlined, title: "Operational Locations", selected: false, onTap: () => Get.to(() => const AdminOperationalLocationsPage())),
                      const SizedBox(height: 6),
                      _SidebarItem(icon: Icons.pending_actions_rounded, title: "Driver Salary Pending", selected: false, onTap: () => Get.to(() => const AdminPendingSalaryPage())),
                      const SizedBox(height: 6),
                      _SidebarItem(icon: Icons.verified_rounded, title: "Driver Salary Paid", selected: false, onTap: () => Get.to(() => const AdminPaidSalaryPage())),
                      const SizedBox(height: 6),
                      _SidebarItem(icon: Icons.people_outline_rounded, title: "Users Salary Pending", selected: false, onTap: () => Get.to(() => const AdminUserSalaryPage(paid: false))),
                      const SizedBox(height: 6),
                      _SidebarItem(icon: Icons.people_alt_rounded, title: "Users Salary Paid", selected: false, onTap: () => Get.to(() => const AdminUserSalaryPage(paid: true))),

                      const SizedBox(height: 6),

                      // PROFILE
                      _SidebarItem(
                        icon:
                            Icons.person_rounded,
                        title: "Profile",
                        selected:
                            controller.currentIndex.value ==
                                1,
                        onTap: () {
                          controller.currentIndex.value =
                              1;

                          controller.box.write(
                            'currentIndex',
                            1,
                          );
                        },
                      ),

                      const SizedBox(height: 6),

                      // SETTINGS
                      _SidebarItem(
                        icon:
                            Icons.settings_rounded,
                        title: "Settings",
                        selected:
                            controller.currentIndex.value ==
                                2,
                        onTap: () {
                          controller.currentIndex.value =
                              2;

                          controller.box.write(
                            'currentIndex',
                            2,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // =================================================
              // SIDEBAR FOOTER
              // =================================================

              Container(
                margin:
                    const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: primaryLight,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Row(
                  children: [

                    Container(
                      width: 38,
                      height: 38,
                      decoration:
                          BoxDecoration(
                        color: primary,
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: const Icon(
                        Icons
                            .admin_panel_settings_rounded,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Administrator",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.w700,
                              fontSize: 13,
                              color: textDark,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            "Control Panel",
                            style: TextStyle(
                              fontSize: 11,
                              color: textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ====================================================
        // MAIN CONTENT
        // ====================================================

        Expanded(
          child: Column(
            children: [

              _DesktopTopBar(
                title: getPageTitle(),
                controller: controller,
              ),

              Expanded(
                child: Container(
                  color: pageBackground,
                  child: Obx(
                    () => pages[
                        controller.currentIndex.value],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// ============================================================
// RESPONSIVE DESKTOP TOP BAR
// ============================================================

class _DesktopTopBar extends StatelessWidget {
  final String title;
  final Usergetxcontroller controller;

  const _DesktopTopBar({
    required this.title,
    required this.controller,
  });

  // ==========================================================
  // BACK BUTTON
  // ==========================================================

  void goBack() {
    final navigator =
        Get.key.currentState;

    if (navigator != null &&
        navigator.canPop()) {
      Get.back();
      return;
    }

    controller.currentIndex.value = 0;

    controller.box.write(
      'currentIndex',
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        final double width =
            constraints.maxWidth;

        // ====================================================
        // RESPONSIVE FLAGS
        // ====================================================

        final bool showSearch =
            width >= 900;

        final bool largeSearch =
            width >= 1150;

        final bool showProfileText =
            width >= 1000;

        final double searchWidth =
            largeSearch ? 240 : 150;

        return Container(
          height: 78,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration:
              const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: borderColor,
              ),
            ),
          ),
          child: Row(
            children: [

              // ==================================================
              // BACK BUTTON
              // ==================================================

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: goBack,
                  borderRadius:
                      BorderRadius.circular(10),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration:
                        BoxDecoration(
                      color: pageBackground,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: const Icon(
                      Icons
                          .arrow_back_rounded,
                      color: textDark,
                      size: 21,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ==================================================
              // TITLE
              // ==================================================

              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w800,
                        color: textDark,
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      "Manage your BRD platform",
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: textGrey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ==================================================
              // SEARCH
              // ==================================================

              if (showSearch)
                SizedBox(
                  width: searchWidth,
                  height: 42,
                  child: Container(
                    decoration:
                        BoxDecoration(
                      color: pageBackground,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child:
                        const TextField(
                      decoration:
                          InputDecoration(
                        border:
                            InputBorder.none,
                        prefixIcon:
                            Icon(
                          Icons
                              .search_rounded,
                          size: 19,
                          color:
                              textGrey,
                        ),
                        hintText:
                            "Search...",
                        hintStyle:
                            TextStyle(
                          fontSize: 12,
                          color:
                              textGrey,
                        ),
                        contentPadding:
                            EdgeInsets.only(
                          top: 12,
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(width: 10),

              // ==================================================
              // NOTIFICATION
              // ==================================================

              Stack(
                children: [

                  Container(
                    width: 42,
                    height: 42,
                    decoration:
                        BoxDecoration(
                      color:
                          pageBackground,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: const Icon(
                      Icons
                          .notifications_none_rounded,
                      color: textDark,
                      size: 21,
                    ),
                  ),

                  Positioned(
                    right: 8,
                    top: 7,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration:
                          const BoxDecoration(
                        color: primary,
                        shape:
                            BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              // ==================================================
              // VERTICAL DIVIDER
              // ==================================================

              if (showProfileText)
                Container(
                  height: 35,
                  width: 1,
                  color: borderColor,
                ),

              if (showProfileText)
                const SizedBox(width: 12),

              // ==================================================
              // PROFILE
              // ==================================================

              GestureDetector(
                onTap: () {
                  controller.currentIndex.value =
                      1;

                  controller.box.write(
                    'currentIndex',
                    1,
                  );
                },
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [

                    _DesktopProfileAvatar(),

                    if (showProfileText) ...[

                      const SizedBox(width: 8),

                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          Text(
                            "Administrator",
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w700,
                              color: textDark,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            "Admin",
                            style: TextStyle(
                              fontSize: 10,
                              color: textGrey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 5),

                      const Icon(
                        Icons
                            .keyboard_arrow_down_rounded,
                        color: textGrey,
                        size: 18,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


// ============================================================
// DESKTOP PROFILE AVATAR
// ============================================================

class _DesktopProfileAvatar
    extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<Usergetxcontroller>();

    return Obx(
      () {
        final image =
            controller.profilePicture.value;

        if (image.isNotEmpty) {
          return CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(image),
            backgroundColor:
                primaryLight,
          );
        }

        return Container(
          width: 40,
          height: 40,
          decoration:
              BoxDecoration(
            color: primaryLight,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  primary.withOpacity(.15),
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: primary,
            size: 21,
          ),
        );
      },
    );
  }
}


// ============================================================
// BRD LOGO
// ============================================================

class _BRDLogo extends StatelessWidget {
  const _BRDLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Row(
        children: [

          Container(
            width: 46,
            height: 46,
            decoration:
                BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  primary,
                  primaryDark,
                ],
                begin:
                    Alignment.topLeft,
                end:
                    Alignment.bottomRight,
              ),
              borderRadius:
                  BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color:
                      primary.withOpacity(
                    .18,
                  ),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons
                  .directions_car_filled_rounded,
              color: Colors.white,
              size: 25,
            ),
          ),

          const SizedBox(width: 12),

          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                "BRD",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w900,
                  letterSpacing: 1.2,
                  color: primaryDark,
                ),
              ),

              Text(
                "ADMIN PANEL",
                style: TextStyle(
                  fontSize: 8,
                  fontWeight:
                      FontWeight.w700,
                  letterSpacing: 1.5,
                  color: textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ============================================================
// SIDEBAR SECTION TITLE
// ============================================================

class _SidebarSectionTitle
    extends StatelessWidget {

  final String title;

  const _SidebarSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          Alignment.centerLeft,
      child: Padding(
        padding:
            const EdgeInsets.only(
          left: 13,
          bottom: 7,
        ),
        child: Text(
          title,
          style:
              const TextStyle(
            fontSize: 10,
            fontWeight:
                FontWeight.w800,
            letterSpacing: 1.2,
            color: textGrey,
          ),
        ),
      ),
    );
  }
}


// ============================================================
// SIDEBAR ITEM
// ============================================================

class _SidebarItem
    extends StatelessWidget {

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(11),
        child:
            AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 180,
          ),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 12,
          ),
          decoration:
              BoxDecoration(
            color: selected
                ? primaryLight
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(11),
          ),
          child: Row(
            children: [

              Icon(
                icon,
                size: 20,
                color: selected
                    ? primary
                    : textGrey,
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Text(
                  title,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: selected
                        ? primaryDark
                        : textDark,
                  ),
                ),
              ),

              if (badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration:
                      BoxDecoration(
                    color: primary,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    badge!,
                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ),

              if (selected)
                Container(
                  width: 4,
                  height: 24,
                  decoration:
                      BoxDecoration(
                    color: primary,
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Admingetxcontroller
      adminController =
      Get.put(
    Admingetxcontroller(),
  );

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width;

    final isDesktop = width >= 900;

    return SafeArea(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(),
        padding:
            EdgeInsets.all(
          isDesktop ? 30 : 18,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            _WelcomePanel(
              isDesktop: isDesktop,
            ),

            const SizedBox(height: 28),

            const _SectionTitle(
              title: "Overview",
              subtitle:
                  "Quick overview of your platform",
            ),

            const SizedBox(height: 16),

            LayoutBuilder(
              builder:
                  (context, constraints) {

                if (constraints.maxWidth >=
                    1100) {
                  return Row(
                    children: [

                      Expanded(
                        child:
                            _StatCard(
                          title:
                              "Total Users",
                          value: "1,248",
                          subtitle:
                              "Registered accounts",
                          icon:
                              Icons.people_alt_rounded,
                          iconBackground:
                              primaryLight,
                          iconColor:
                              primary,
                          trend: "+12.5%",
                          trendUp: true,
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(
                        child:
                            _StatCard(
                          title:
                              "Active Drivers",
                          value: "326",
                          subtitle:
                              "Currently available",
                          icon:
                              Icons.local_taxi_rounded,
                          iconBackground:
                              const Color(
                            0xFFEAF7F0,
                          ),
                          iconColor:
                              const Color(
                            0xFF15803D,
                          ),
                          trend: "+8.2%",
                          trendUp: true,
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(
                        child:
                            _StatCard(
                          title:
                              "Pending Requests",
                          value: "24",
                          subtitle:
                              "Awaiting review",
                          icon:
                              Icons.assignment_rounded,
                          iconBackground:
                              const Color(
                            0xFFFFF4E5,
                          ),
                          iconColor:
                              const Color(
                            0xFFD97706,
                          ),
                          trend:
                              "Needs attention",
                          trendUp: false,
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(
                        child:
                            _StatCard(
                          title:
                              "Total Revenue",
                          value: "৳84.6K",
                          subtitle:
                              "This month's revenue",
                          icon:
                              Icons.payments_rounded,
                          iconBackground:
                              const Color(
                            0xFFEFF6FF,
                          ),
                          iconColor:
                              const Color(
                            0xFF2563EB,
                          ),
                          trend: "+18.4%",
                          trendUp: true,
                        ),
                      ),
                    ],
                  );
                }

                return GridView.count(
                  crossAxisCount:
                      constraints.maxWidth >
                              650
                          ? 2
                          : 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      constraints.maxWidth >
                              650
                          ? 2.3
                          : 2.5,
                  children: [

                    _StatCard(
                      title:
                          "Total Users",
                      value: "1,248",
                      subtitle:
                          "Registered accounts",
                      icon:
                          Icons.people_alt_rounded,
                      iconBackground:
                          primaryLight,
                      iconColor:
                          primary,
                      trend: "+12.5%",
                      trendUp: true,
                    ),

                    _StatCard(
                      title:
                          "Active Drivers",
                      value: "326",
                      subtitle:
                          "Currently available",
                      icon:
                          Icons.local_taxi_rounded,
                      iconBackground:
                          const Color(
                        0xFFEAF7F0,
                      ),
                      iconColor:
                          const Color(
                        0xFF15803D,
                      ),
                      trend: "+8.2%",
                      trendUp: true,
                    ),

                    _StatCard(
                      title:
                          "Pending Requests",
                      value: "24",
                      subtitle:
                          "Awaiting review",
                      icon:
                          Icons.assignment_rounded,
                      iconBackground:
                          const Color(
                        0xFFFFF4E5,
                      ),
                      iconColor:
                          const Color(
                        0xFFD97706,
                      ),
                      trend:
                          "Needs attention",
                      trendUp: false,
                    ),

                    _StatCard(
                      title:
                          "Total Revenue",
                      value: "৳84.6K",
                      subtitle:
                          "This month's revenue",
                      icon:
                          Icons.payments_rounded,
                      iconBackground:
                          const Color(
                        0xFFEFF6FF,
                      ),
                      iconColor:
                          const Color(
                        0xFF2563EB,
                      ),
                      trend: "+18.4%",
                      trendUp: true,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            const _SectionTitle(
              title: "Management",
              subtitle:
                  "Access important administration tools",
            ),

            const SizedBox(height: 16),

            Categories(),

            const SizedBox(height: 30),

            _SystemOverview(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// WELCOME PANEL
// ============================================================

class _WelcomePanel
    extends StatelessWidget {

  final bool isDesktop;

  const _WelcomePanel({
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(
        isDesktop ? 30 : 22,
      ),
      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            primaryDark,
            primary,
          ],
          begin:
              Alignment.topLeft,
          end:
              Alignment.bottomRight,
        ),
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
                primary.withOpacity(.16),
            blurRadius: 25,
            offset:
                const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Text(
                  "Welcome back, Administrator 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Monitor your BRD platform, manage users and drivers, and keep everything running smoothly.",
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(.78),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.white
                        .withOpacity(.12),
                    borderRadius:
                        BorderRadius.circular(
                      8,
                    ),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(.15),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [

                      Icon(
                        Icons.circle,
                        color:
                            Color(0xFF4ADE80),
                        size: 9,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "System is operational",
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isDesktop)
            Container(
              width: 150,
              height: 150,
              margin:
                  const EdgeInsets.only(
                left: 30,
              ),
              decoration:
                  BoxDecoration(
                color: Colors.white
                    .withOpacity(.07),
                shape: BoxShape.circle,
              ),
              child:
                  const Center(
                child: Icon(
                  Icons
                      .admin_panel_settings_rounded,
                  color: Colors.white,
                  size: 75,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle
    extends StatelessWidget {

  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style:
              const TextStyle(
            fontSize: 19,
            fontWeight:
                FontWeight.w800,
            color: textDark,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          subtitle,
          style:
              const TextStyle(
            fontSize: 12,
            color: textGrey,
          ),
        ),
      ],
    );
  }
}


// ============================================================
// STAT CARD
// ============================================================

class _StatCard
    extends StatelessWidget {

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String trend;
  final bool trendUp;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.trend,
    required this.trendUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(.025),
            blurRadius: 12,
            offset:
                const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [

          Container(
            width: 52,
            height: 52,
            decoration:
                BoxDecoration(
              color:
                  iconBackground,
              borderRadius:
                  BorderRadius.circular(
                13,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 25,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 12,
                    color: textGrey,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w800,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [

                    Icon(
                      trendUp
                          ? Icons
                              .trending_up_rounded
                          : Icons
                              .warning_amber_rounded,
                      size: 13,
                      color: trendUp
                          ? const Color(
                              0xFF15803D,
                            )
                          : const Color(
                              0xFFD97706,
                            ),
                    ),

                    const SizedBox(width: 4),

                    Flexible(
                      child: Text(
                        trend,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style:
                            TextStyle(
                          fontSize: 10,
                          fontWeight:
                              FontWeight.w600,
                          color: trendUp
                              ? const Color(
                                  0xFF15803D,
                                )
                              : const Color(
                                  0xFFD97706,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// CATEGORIES
// ============================================================

class Categories
    extends StatelessWidget {

  Categories({super.key});

  final Admingetxcontroller
      admingetxcontroller =
      Get.put(
    Admingetxcontroller(),
  );

  @override
  Widget build(BuildContext context) {

    final categories = [

      _CategoryData(
        title: "Users",
        subtitle: "Manage users",
        iconData:
            Icons.people_alt_rounded,
        color: primary,
        onTap: () {
          if (!admingetxcontroller
              .isLoading
              .value) {
            admingetxcontroller
                .fetchUserList();
          }
        },
      ),

      _CategoryData(
        title: "Drivers",
        subtitle: "Manage drivers",
        iconData:
            Icons.local_taxi_rounded,
        color:
            const Color(0xFF15803D),
        onTap: () {
          admingetxcontroller
              .loadDrivers();
        },
      ),

      _CategoryData(
        title: "Requests",
        subtitle:
            "Review applications",
        iconData:
            Icons.assignment_rounded,
        color:
            const Color(0xFFD97706),
        onTap: () {
          admingetxcontroller
              .fetchDriveList();
        },
      ),

      _CategoryData(
        title: "Messages",
        subtitle:
            "User communication",
        iconData:
            Icons.message_rounded,
        color:
            const Color(0xFF2563EB),
        onTap: () {
          Get.to(
            () =>
                UserContactManagement(),
          );
        },
      ),

      _CategoryData(
        title: "Notifications",
        subtitle:
            "Send notifications",
        iconData:
            Icons.notifications_rounded,
        color:
            const Color(0xFF7C3AED),
        onTap: () {},
      ),

      _CategoryData(
        title: "Offers",
        subtitle: "Manage offers",
        iconData:
            Icons.local_offer_rounded,
        color:
            const Color(0xFFDB2777),
        onTap: () {},
      ),

      _CategoryData(
        title: "Reports",
        subtitle: "View reports",
        iconData:
            Icons.analytics_rounded,
        color:
            const Color(0xFF0891B2),
        onTap: () {},
      ),

      _CategoryData(
        title: "Settings",
        subtitle:
            "System settings",
        iconData:
            Icons.settings_rounded,
        color:
            const Color(0xFF475569),
        onTap: () {},
      ),
    ];

    return LayoutBuilder(
      builder:
          (context, constraints) {

        int columns;

        if (constraints.maxWidth >=
            1200) {
          columns = 4;
        } else if (constraints.maxWidth >=
            700) {
          columns = 3;
        } else {
          columns = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          itemCount:
              categories.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                columns,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio:
                columns == 2
                    ? 1.65
                    : 1.45,
          ),
          itemBuilder:
              (context, index) {

            final item =
                categories[index];

            return CategoryCard(
              title: item.title,
              subtitle:
                  item.subtitle,
              iconData:
                  item.iconData,
              color: item.color,
              onTap: item.onTap,
            );
          },
        );
      },
    );
  }
}


// ============================================================
// CATEGORY DATA
// ============================================================

class _CategoryData {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  _CategoryData({
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.color,
    required this.onTap,
  });
}


// ============================================================
// CATEGORY CARD
// ============================================================

class CategoryCard
    extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final bool isLoading;

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.color,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(15),
      child: InkWell(
        onTap:
            isLoading ? null : onTap,
        borderRadius:
            BorderRadius.circular(15),
        child: Container(
          padding:
              const EdgeInsets.all(17),
          decoration:
              BoxDecoration(
            borderRadius:
                BorderRadius.circular(15),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Container(
                    width: 45,
                    height: 45,
                    decoration:
                        BoxDecoration(
                      color:
                          color.withOpacity(
                        .10,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: isLoading
                        ? const Padding(
                            padding:
                                EdgeInsets.all(
                              13,
                            ),
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: primary,
                            ),
                          )
                        : Icon(
                            iconData,
                            color: color,
                            size: 22,
                          ),
                  ),

                  const Spacer(),

                  Container(
                    width: 29,
                    height: 29,
                    decoration:
                        BoxDecoration(
                      color:
                          pageBackground,
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),
                    ),
                    child:
                        const Icon(
                      Icons
                          .arrow_forward_rounded,
                      size: 15,
                      color: textGrey,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Text(
                title,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w700,
                  color: textDark,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    const TextStyle(
                  fontSize: 11,
                  color: textGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ============================================================
// SYSTEM OVERVIEW
// ============================================================

class _SystemOverview
    extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(22),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              Icon(
                Icons
                    .monitor_heart_rounded,
                color: primary,
                size: 21,
              ),

              SizedBox(width: 9),

              Text(
                "System Overview",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w800,
                  color: textDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const _SystemStatusRow(
            title: "API Server",
            status: "Operational",
          ),

          const Divider(
            height: 22,
            color: borderColor,
          ),

          const _SystemStatusRow(
            title: "Database",
            status: "Connected",
          ),

          const Divider(
            height: 22,
            color: borderColor,
          ),

          const _SystemStatusRow(
            title: "Authentication",
            status: "Active",
          ),

          const Divider(
            height: 22,
            color: borderColor,
          ),

          const _SystemStatusRow(
            title: "Driver Service",
            status: "Running",
          ),
        ],
      ),
    );
  }
}


// ============================================================
// SYSTEM STATUS ROW
// ============================================================

class _SystemStatusRow
    extends StatelessWidget {

  final String title;
  final String status;

  const _SystemStatusRow({
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Container(
          width: 38,
          height: 38,
          decoration:
              BoxDecoration(
            color: primaryLight,
            borderRadius:
                BorderRadius.circular(
              10,
            ),
          ),
          child: const Icon(
            Icons
                .check_circle_rounded,
            color: primary,
            size: 19,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            overflow:
                TextOverflow.ellipsis,
            style:
                const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
              color: textDark,
            ),
          ),
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration:
              BoxDecoration(
            color:
                const Color(0xFFEAF7F0),
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),
          child: Row(
            mainAxisSize:
                MainAxisSize.min,
            children: [

              Container(
                width: 6,
                height: 6,
                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFF16A34A),
                  shape:
                      BoxShape.circle,
                ),
              ),

              const SizedBox(width: 6),

              Text(
                status,
                style:
                    const TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      Color(0xFF15803D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// ============================================================
// MOBILE NAVIGATION
// ============================================================

class CustomNavBar
    extends StatelessWidget {

  CustomNavBar({super.key});

  final Usergetxcontroller controller =
      Get.find<Usergetxcontroller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration:
            const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceAround,
              children: [

                _NavItem(
                  icon:
                      Icons.dashboard_rounded,
                  label: "Home",
                  selected:
                      controller.currentIndex.value ==
                          0,
                  onTap: () {
                    controller.currentIndex.value =
                        0;

                    controller.box.write(
                      'currentIndex',
                      0,
                    );
                  },
                ),

                _NavItem(
                  icon:
                      Icons.person_rounded,
                  label: "Profile",
                  selected:
                      controller.currentIndex.value ==
                          1,
                  onTap: () {
                    controller.currentIndex.value =
                        1;

                    controller.box.write(
                      'currentIndex',
                      1,
                    );
                  },
                ),

                _NavItem(
                  icon:
                      Icons.settings_rounded,
                  label: "Settings",
                  selected:
                      controller.currentIndex.value ==
                          2,
                  onTap: () {
                    controller.currentIndex.value =
                        2;

                    controller.box.write(
                      'currentIndex',
                      2,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ============================================================
// NAV ITEM
// ============================================================

class _NavItem
    extends StatelessWidget {

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 180,
        ),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        decoration:
            BoxDecoration(
          color: selected
              ? primaryLight
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [

            Icon(
              icon,
              color: selected
                  ? primary
                  : textGrey,
              size: 22,
            ),

            const SizedBox(height: 3),

            Text(
              label,
              style:
                  TextStyle(
                fontSize: 10,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: selected
                    ? primary
                    : textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// HOME HEADER
// ============================================================

class HomeHeader
    extends StatelessWidget {

  HomeHeader({super.key});

  final Usergetxcontroller controller =
      Get.find<Usergetxcontroller>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        GestureDetector(
          onTap: () {
            Get.to(
              () => Userprofile(),
            );
          },
          child: Obx(
            () {
              final image =
                  controller
                      .profilePicture
                      .value;

              if (image.isNotEmpty) {
                return CircleAvatar(
                  radius: 23,
                  backgroundImage:
                      NetworkImage(image),
                );
              }

              return const CircleAvatar(
                radius: 23,
                backgroundColor:
                    primaryLight,
                child: Icon(
                  Icons
                      .person_rounded,
                  color: primary,
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 11,
                  color: textGrey,
                ),
              ),

              SizedBox(height: 3),

              Text(
                "Administrator",
                style:
                    TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w800,
                  color: textDark,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons
                .notifications_none_rounded,
            color: textDark,
          ),
        ),
      ],
    );
  }
}


// ============================================================
// SEARCH FIELD
// ============================================================

class SearchField
    extends StatelessWidget {

  final String hintText;

  const SearchField({
    super.key,
    this.hintText = "Search...",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          11,
        ),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: TextField(
        decoration:
            InputDecoration(
          hintText: hintText,
          hintStyle:
              const TextStyle(
            color: textGrey,
            fontSize: 12,
          ),
          prefixIcon:
              const Icon(
            Icons.search_rounded,
            size: 20,
            color: textGrey,
          ),
          border:
              InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 12,
          ),
        ),
      ),
    );
  }
}


// ============================================================
// ICON BUTTON WITH COUNTER
// ============================================================

class IconBtnWithCounter
    extends StatelessWidget {

  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  const IconBtnWithCounter({
    super.key,
    required this.icon,
    this.count = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior:
            Clip.none,
        children: [

          Container(
            width: 42,
            height: 42,
            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                10,
              ),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Icon(
              icon,
              color: textDark,
              size: 21,
            ),
          ),

          if (count > 0)
            Positioned(
              right: -2,
              top: -3,
              child: Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration:
                    const BoxDecoration(
                  color: primary,
                  shape:
                      BoxShape.circle,
                ),
                child: Text(
                  count > 9
                      ? "9+"
                      : "$count",
                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontSize: 8,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}