import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Drivergetxcontroller.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'DriverNotificationsPage.dart';
import 'DriverNotificationController.dart';
import 'DriverSalaryHistoryPage.dart';
import 'DriverUnpaidSalaryPage.dart';
import 'DriverServiceHistoryPage.dart';
import 'package:brd/hire_service/views/driver_live_location_entry.dart';


final Usergetxcontroller userController =
    Get.find<Usergetxcontroller>();

class DriverDashboard extends StatefulWidget {

   DriverDashboard({super.key});

  

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  // ================================================================
  // PROFESSIONAL DRIVER DASHBOARD THEME
  // ================================================================

  static const Color primary = Color(0xFF123B35);
  static const Color primaryDark = Color(0xFF092A25);
  static const Color accent = Color(0xFF18A999);

  static const Color background = Color(0xFFF4F7F6);
  static const Color white = Colors.white;

  static const Color textPrimary = Color(0xFF17211F);
  static const Color textSecondary = Color(0xFF6D7976);
  static const Color border = Color(0xFFE1E8E5);

  static const Color success = Color(0xFF159A6A);
  static const Color warning = Color(0xFFE59A23);
  static const Color danger = Color(0xFFD94A4A);

  // ================================================================
  // DRIVER CONTROLLER
  // ================================================================

  final Drivergetxcontroller driverController = Get.put(Drivergetxcontroller());
  final DriverNotificationController notificationController =
      Get.put(DriverNotificationController(), permanent: true);

  int selectedIndex = 0;
  bool isOnline = true;

  // ================================================================
  // VEHICLE INFORMATION
  // ================================================================

  final String vehicleName = "Toyota Axio";
  final String vehicleNumber = "DHAKA METRO-GA 12-3456";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: [
            _buildHomePage(context),
            _buildTripsPage(),
            _buildEarningsPage(),
            _buildProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ================================================================
  // HOME
  // ================================================================

  Widget _buildHomePage(BuildContext context) {
    return RefreshIndicator(
      color: accent,
      onRefresh: () async {
        await driverController.loadDriverProfile();

        await Future.delayed(const Duration(milliseconds: 300));
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: _buildAvailabilityCard(),
            ),
          ),

          SliverToBoxAdapter(
            child: _sectionHeader(
              "Today's Performance",
              "Your driving summary",
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: _buildStatistics(),
            ),
          ),

          SliverToBoxAdapter(
            child: _sectionHeader("Active Assignment", "Your current service"),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: _buildAssignmentCard(),
            ),
          ),

          SliverToBoxAdapter(
            child: _sectionHeader("Quick Access", "Frequently used options"),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: _buildQuickActions(),
            ),
          ),

          SliverToBoxAdapter(
            child: _sectionHeader("Recent Activity", "Your latest updates"),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
              child: _buildRecentActivity(),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // HEADER
  // ================================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryDark, primary],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Builder(
                builder: (context) {
                  return _headerButton(
                    icon: Icons.menu_rounded,
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Obx(() {
                  final String name = driverController.fullName.value.trim();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(.62),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        name.isEmpty ? "Driver" : name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  );
                }),
              ),

              _headerButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {
                  Get.to(() => DriverNotificationsPage());
                },
                badge: true,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // DRIVER MINI PROFILE
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(.09)),
            ),
            child: Row(
              children: [
                _buildDriverAvatar(size: 58, iconSize: 32, borderRadius: 17),

                const SizedBox(width: 13),

                Expanded(
                  child: Obx(() {
                    final String name = driverController.fullName.value.trim();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.isEmpty ? "Professional Driver" : name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car_outlined,
                              color: Colors.white.withOpacity(.55),
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                vehicleName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.60),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),

                _statusBadge(isOnline ? "ONLINE" : "OFFLINE", isOnline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerButton({
    required IconData icon,
    required VoidCallback onTap,
    bool badge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.09),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(.08)),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),

          if (badge)
            Positioned(
              top: 7,
              right: 8,
              child: Container(
                height: 7,
                width: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC857),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusBadge(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF159A6A).withOpacity(.17)
            : Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
              color: active ? const Color(0xFF5BE0A8) : Colors.white54,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: active ? const Color(0xFF8BE9C0) : Colors.white60,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: .5,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // DRIVER AVATAR
  // ================================================================

  Widget _buildDriverAvatar({
    required double size,
    required double iconSize,
    required double borderRadius,
  }) {
    return Obx(() {
      final String profilePicture = driverController.profilePicture.value
          .trim();

      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: profilePicture.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.network(
                  profilePicture,
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person_rounded,
                      color: primary,
                      size: iconSize,
                    );
                  },
                ),
              )
            : Icon(Icons.person_rounded, color: primary, size: iconSize),
      );
    });
  }

  // ================================================================
  // AVAILABILITY
  // ================================================================

  Widget _buildAvailabilityCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: isOnline
                  ? const Color(0xFFE7F8F1)
                  : const Color(0xFFF1F3F3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isOnline ? Icons.wifi_rounded : Icons.wifi_off_rounded,
              color: isOnline ? success : textSecondary,
              size: 23,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOnline ? "You're available" : "You're offline",
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isOnline
                      ? "Ready to receive new assignments"
                      : "Turn on availability to receive work",
                  maxLines: 2,
                  style: const TextStyle(color: textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),

          Switch.adaptive(
            value: isOnline,
            activeColor: accent,
            onChanged: (value) {
              setState(() {
                isOnline = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SECTION HEADER
  // ================================================================

  Widget _sectionHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 28, 18, 13),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: textSecondary, fontSize: 10.5),
                ),
              ],
            ),
          ),

          const Icon(Icons.more_horiz_rounded, color: textSecondary, size: 21),
        ],
      ),
    );
  }

  // ================================================================
  // STATISTICS
  // ================================================================

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            Icons.route_rounded,
            "08",
            "Trips",
            accent,
            const Color(0xFFE7F8F1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            Icons.schedule_rounded,
            "6.5h",
            "Driving",
            const Color(0xFF7B61C9),
            const Color(0xFFF1EDFC),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            Icons.star_rounded,
            "4.9",
            "Rating",
            warning,
            const Color(0xFFFFF6E3),
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    IconData icon,
    String value,
    String label,
    Color iconColor,
    Color iconBackground,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 11),
          Text(
            value,
            style: const TextStyle(
              color: textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // ACTIVE ASSIGNMENT
  // ================================================================

  Widget _buildAssignmentCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, primaryDark],
        ),
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(.20),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF159A6A).withOpacity(.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF65E3AD), size: 7),
                    SizedBox(width: 6),
                    Text(
                      "ACTIVE",
                      style: TextStyle(
                        color: Color(0xFF8BE9C0),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                "#BRD-2048",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _locationDot(const Color(0xFF6CC8FF)),
                  Container(width: 1, height: 39, color: Colors.white24),
                  _locationDot(const Color(0xFF65E3AD)),
                ],
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Banani, Dhaka",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 26),
                    Text(
                      "Gulshan 2, Dhaka",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "09:30 AM",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                  SizedBox(height: 27),
                  Text(
                    "10:00 AM",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(height: 1, color: Colors.white.withOpacity(.08)),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: Colors.white54,
                size: 18,
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  "Ahmed Rahman",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                Icons.directions_car_outlined,
                color: Colors.white54,
                size: 17,
              ),
              const SizedBox(width: 5),
              Text(
                vehicleName,
                style: const TextStyle(color: Colors.white70, fontSize: 10.5),
              ),
            ],
          ),

          const SizedBox(height: 17),

          SizedBox(
            height: 46,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _showComingSoon("Assignment Details");
              },
              icon: const Icon(Icons.arrow_forward_rounded, size: 17),
              label: const Text(
                "View Assignment",
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationDot(Color color) {
    return Container(
      height: 13,
      width: 13,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  // ================================================================
  // QUICK ACTIONS
  // ================================================================

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _quickAction(
            Icons.assignment_outlined,
            "Assignments",
            "Your tasks",
            accent,
            const Color(0xFFE7F8F1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _quickAction(
            Icons.account_balance_wallet_outlined,
            "Earnings",
            "Your salary",
            const Color(0xFF7B61C9),
            const Color(0xFFF1EDFC),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _quickAction(
            Icons.directions_car_outlined,
            "Vehicle",
            "Car details",
            warning,
            const Color(0xFFFFF6E3),
          ),
        ),
      ],
    );
  }

  Widget _quickAction(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
    Color iconBackground,
  ) {
    return InkWell(
      onTap: () {
        if (title == "Earnings") {
          Get.to(() => const DriverSalaryHistoryPage());
        } else if (title == "Assignments") {
          setState(() {
            selectedIndex = 1;
          });
        } else {
          _showComingSoon(title);
        }
      },
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: iconColor, size: 19),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: textSecondary, fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // RECENT ACTIVITY
  // ================================================================

  Widget _buildRecentActivity() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          _activity(
            Icons.check_circle_outline_rounded,
            success,
            const Color(0xFFE7F8F1),
            "Trip completed",
            "Banani → Gulshan 2",
            "10 min ago",
          ),
          _divider(),
          _activity(
            Icons.assignment_outlined,
            accent,
            const Color(0xFFE7F8F1),
            "New assignment",
            "Service #BRD-2048",
            "1 hour ago",
          ),
          _divider(),
          _activity(
            Icons.payments_outlined,
            const Color(0xFF7B61C9),
            const Color(0xFFF1EDFC),
            "Salary processed",
            "Monthly salary",
            "Yesterday",
          ),
        ],
      ),
    );
  }

  Widget _activity(
    IconData icon,
    Color iconColor,
    Color iconBackground,
    String title,
    String subtitle,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: textSecondary, fontSize: 10.5),
                ),
              ],
            ),
          ),

          Text(time, style: const TextStyle(color: textSecondary, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, indent: 68, endIndent: 14, color: border);
  }

  // ================================================================
  // TRIPS PAGE
  // ================================================================

  Widget _buildTripsPage() {
    return _pageLayout(
      title: "My Trips",
      subtitle: "Track your driving activity",
      icon: Icons.route_rounded,
      child: Column(
        children: [
          _tripCard("Banani → Gulshan 2", "Today • 09:30 AM", "Completed"),
          const SizedBox(height: 11),
          _tripCard(
            "Dhanmondi → Motijheel",
            "Yesterday • 04:15 PM",
            "Completed",
          ),
          const SizedBox(height: 11),
          _tripCard("Gulshan → Airport", "Yesterday • 10:20 AM", "Completed"),
        ],
      ),
    );
  }

  Widget _tripCard(String route, String date, String status) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F8F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.route_rounded, color: accent, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: const TextStyle(color: textSecondary, fontSize: 10.5),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F8F1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Done",
              style: TextStyle(
                color: success,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // EARNINGS
  // ================================================================

  Widget _buildEarningsPage() {
    return _pageLayout(
      title: "My Earnings",
      subtitle: "Monitor salary and payments",
      icon: Icons.account_balance_wallet_rounded,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(21),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [primary, primaryDark]),
              borderRadius: BorderRadius.circular(21),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "August 2026",
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                ),
                SizedBox(height: 8),
                Text(
                  "৳ 28,500",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  "Current monthly earnings",
                  style: TextStyle(color: Colors.white60, fontSize: 10.5),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _earningInfo(
                  "Completed Trips",
                  "42",
                  Icons.check_circle_outline_rounded,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: _earningInfo(
                  "Average Daily",
                  "৳ 1,357",
                  Icons.trending_up_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _earningInfo(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 21),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: textSecondary, fontSize: 9.5),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PROFILE
  // ================================================================
    
  Widget _buildProfilePage() {

    return Obx(() {
      final int userId = userController.userid.value;
      final int profileId = userController.profileId.value;

      final String name = userController.fullName.value.trim();
      final String email = userController.email.value.trim();
      final String phone = userController.phoneNumber.value.trim();
      final String bio = userController.bio.value.trim();
      final String profilePicture = userController.profilePicture.value.trim();

      final bool isLoading = userController.isLoading.value;

      return _pageLayout(
        title: "My Profile",
        subtitle: "Manage your driver account",
        icon: Icons.person_rounded,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: border),
              ),
              child: Column(
                children: [
                  // ==================================================
                  // PROFILE PICTURE
                  // ==================================================

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE7F8F1),
                          shape: BoxShape.circle,
                        ),
                        child: profilePicture.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  profilePicture,
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.person_rounded,
                                      color: primary,
                                      size: 45,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.person_rounded,
                                color: primary,
                                size: 45,
                              ),
                      ),

                      if (isLoading)
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ==================================================
                  // FULL NAME
                  // ==================================================
                  Text(
                    name.isEmpty ? "Driver" : name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // ==================================================
                  // BIO
                  // ==================================================
                  Text(
                    bio.isEmpty ? "Professional Driver" : bio,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: textSecondary, fontSize: 12),
                  ),

                  const SizedBox(height: 22),

                  // ==================================================
                  // USER ID
                  // ==================================================
                  _profileRow(
                    Icons.badge_outlined,
                    "User ID",
                    userId == 0 ? "Not available" : userId.toString(),
                  ),

                  // ==================================================
                  // PROFILE ID
                  // ==================================================
                  _profileRow(
                    Icons.account_circle_outlined,
                    "Profile ID",
                    profileId == 0 ? "Not available" : profileId.toString(),
                  ),

                  // ==================================================
                  // FULL NAME
                  // ==================================================
                  _profileRow(
                    Icons.person_outline_rounded,
                    "Full Name",
                    name.isEmpty ? "Not available" : name,
                  ),

                  // ==================================================
                  // EMAIL
                  // ==================================================
                  _profileRow(
                    Icons.email_outlined,
                    "Email",
                    email.isEmpty ? "Not available" : email,
                  ),

                  // ==================================================
                  // PHONE
                  // ==================================================
                  _profileRow(
                    Icons.phone_outlined,
                    "Phone",
                    phone.isEmpty ? "Not available" : phone,
                  ),

                  // ==================================================
                  // BIO
                  // ==================================================
                  _profileRow(
                    Icons.info_outline_rounded,
                    "Bio",
                    bio.isEmpty ? "Not available" : bio,
                  ),

                  // ==================================================
                  // VEHICLE
                  // ==================================================
                  _profileRow(
                    Icons.directions_car_outlined,
                    "Vehicle",
                    vehicleName,
                  ),

                  // ==================================================
                  // REGISTRATION
                  // ==================================================
                  _profileRow(
                    Icons.confirmation_number_outlined,
                    "Registration",
                    vehicleNumber,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      userController.logout();
    },
    icon: const Icon(Icons.logout),
    label: const Text('Logout'),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF800000),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  ),
),
                ],
              ),
            ),

            const SizedBox(height: 15),

            if (userController.error.value.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.red.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        userController.error.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _profileRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          Container(
            height: 37,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F8F1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 18),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: textSecondary, fontSize: 9.5),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // GENERIC PAGE
  // ================================================================

  Widget _pageLayout({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 19, 18, 25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primaryDark, primary]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.09),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(padding: const EdgeInsets.all(18), child: child),
        ),
      ],
    );
  }

  // ================================================================
  // DRAWER
  // ================================================================

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .82,
      backgroundColor: background,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(21, 25, 21, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [primaryDark, primary]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Obx(() {
                final String name = driverController.fullName.value.trim();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDriverAvatar(
                      size: 63,
                      iconSize: 34,
                      borderRadius: 18,
                    ),

                    const SizedBox(height: 14),

                    Text(
                      name.isEmpty ? "Driver" : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Professional Driver",
                      style: TextStyle(color: Colors.white60, fontSize: 11),
                    ),

                    const SizedBox(height: 14),

                    _statusBadge(
                      isOnline ? "CURRENTLY ONLINE" : "OFFLINE",
                      isOnline,
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 12),

            _drawerItem(Icons.dashboard_outlined, "Dashboard", 0),

            _drawerItem(Icons.route_outlined, "My Trips", 1),

            _drawerItem(Icons.account_balance_wallet_outlined, "Earnings", null, onTap: () => Get.to(() => const DriverSalaryHistoryPage())),
            _drawerItem(Icons.pending_actions_outlined, "Unpaid Salary", null, onTap: () => Get.to(() => const DriverUnpaidSalaryPage())),
            _drawerItem(Icons.verified_outlined, "Paid Salary", null, onTap: () => Get.to(() => const DriverSalaryHistoryPage())),
            _drawerItem(Icons.my_location_outlined, "Live Location", null, onTap: () => Get.to(() => const DriverLiveLocationEntry())),

            _drawerItem(Icons.person_outline_rounded, "My Profile", 3),

            _drawerItem(Icons.directions_car_outlined, "Vehicle", null),

            _drawerItem(Icons.history_rounded, "Service History", null, onTap: () => Get.to(() => const DriverServiceHistoryPage())),

            Obx(() => _drawerItem(
              Icons.notifications_none_rounded,
              notificationController.unreadCount > 0
                  ? "Notifications (${notificationController.unreadCount})"
                  : "Notifications",
              null,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => DriverNotificationsPage());
              },
            )),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              child: Divider(color: border),
            ),

            _drawerItem(Icons.help_outline_rounded, "Help & Support", null),

            _drawerItem(Icons.settings_outlined, "Settings", null),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
              child: InkWell(
                onTap: () {
                  _showLogoutDialog();
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEEE),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.logout_rounded, color: danger, size: 20),
                      SizedBox(width: 11),
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: danger,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int? index, {VoidCallback? onTap}) {
    final bool selected = index != null && selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
      child: Material(
        color: selected ? const Color(0xFFE7F8F1) : Colors.transparent,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap();
              return;
            }
            if (index != null) {
              setState(() {
                selectedIndex = index;
              });
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              _showComingSoon(title);
            }
          },
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(
              children: [
                Icon(icon, color: selected ? accent : textSecondary, size: 21),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: selected ? primary : textPrimary,
                      fontSize: 12.5,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                ),
                if (selected)
                  Container(
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // BOTTOM NAVIGATION
  // ================================================================

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(.08),
            blurRadius: 18,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bottomItem(Icons.home_outlined, Icons.home_rounded, "Home", 0),
              _bottomItem(
                Icons.route_outlined,
                Icons.route_rounded,
                "Trips",
                1,
              ),
              _bottomItem(
                Icons.account_balance_wallet_outlined,
                Icons.account_balance_wallet_rounded,
                "Earnings",
                2,
              ),
              _bottomItem(
                Icons.person_outline_rounded,
                Icons.person_rounded,
                "Profile",
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE7F8F1) : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? activeIcon : icon,
              color: selected ? accent : textSecondary,
              size: 21,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: selected ? primary : textSecondary,
                fontSize: 9.5,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // HELPERS
  // ================================================================

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good morning 👋";
    } else if (hour < 17) {
      return "Good afternoon 👋";
    } else {
      return "Good evening 👋";
    }
  }

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title will be available soon."),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: danger,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
