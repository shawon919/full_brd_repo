import 'dart:async';

import 'package:brd/Car-Owner/templets/UserAccountPage.dart';
import 'package:brd/Car-Owner/templets/UserProfile.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:brd/GETX/Routes/get_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Userdashboard extends StatelessWidget {
  Userdashboard({super.key});

  final Usergetxcontroller controller =
      Get.find<Usergetxcontroller>();

  final List<Widget> pages = [
    const HomeScreen(),
    Userprofile(),
    Useraccountpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }
}

// ============================================================
// APP COLORS
// ============================================================

class AppColors {
  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5C0000);
  static const Color maroonLight = Color(0xFFA52A2A);

  static const Color background = Color(0xFFF8F8FA);
  static const Color white = Colors.white;
  static const Color text = Color(0xFF171717);
  static const Color secondaryText = Color(0xFF737373);
  static const Color border = Color(0xFFE8E8EC);
  static const Color softMaroon = Color(0xFFF7E9E9);
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // APP BAR
          SliverToBoxAdapter(
            child: const HomeAppBar(),
          ),

          // MAIN CONTENT
          SliverToBoxAdapter(
            child: Column(
              children: const [
                SizedBox(height: 16),

                WelcomeSection(),

                SizedBox(height: 18),

                ProfessionalBannerSlider(),

                SizedBox(height: 12),

                ServiceCategories(),

                SizedBox(height: 8),

                QuickServices(),

                SizedBox(height: 8),

                UserHireManagementCard(),

                SizedBox(height: 8),

                ServiceStats(),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MAROON APP BAR
// ============================================================

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Usergetxcontroller controller =
        Get.find<Usergetxcontroller>();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: const BoxDecoration(
        color: AppColors.maroon,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          // PROFILE
          Obx(() {
            final String image =
                controller.profilePicture.value;

            return GestureDetector(
              onTap: () => Get.to(() => Userprofile()),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.7),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: image.isNotEmpty
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 27,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                ),
              ),
            );
          }),

          const SizedBox(width: 13),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "BRD Driver Service",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          // NOTIFICATION
          GestureDetector(
            onTap: () => Get.toNamed(Routers.NOTIFICATIONS),
            child: Container(
              width: 46,
              height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),

                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }
}

// ============================================================
// WELCOME SECTION
// ============================================================

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your journey,",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "our responsibility.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.maroon,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.softMaroon,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.directions_car_filled_rounded,
              color: AppColors.maroon,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFESSIONAL BANNER MODEL
//
// IMPORTANT:
// This is NOT BannerData.
// This removes the previous type mismatch completely.
// ============================================================

class ProfessionalBanner {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData icon;
  final IconData secondaryIcon;

  const ProfessionalBanner({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    required this.secondaryIcon,
  });
}

// ============================================================
// BANNER SLIDER
// ============================================================

class ProfessionalBannerSlider extends StatefulWidget {
  const ProfessionalBannerSlider({super.key});

  @override
  State<ProfessionalBannerSlider> createState() =>
      _ProfessionalBannerSliderState();
}

class _ProfessionalBannerSliderState
    extends State<ProfessionalBannerSlider> {
  final PageController _pageController =
      PageController();

  Timer? _timer;

  int _currentPage = 0;

  // STRONGLY TYPED LIST
  // No List<Map<String, dynamic>>
  // No BannerData mismatch
  final List<ProfessionalBanner> banners = const [
    ProfessionalBanner(
      title: "Reliable Drivers",
      subtitle:
          "Professional drivers ready to make every journey safer.",
      buttonText: "Find a Driver",
      icon: Icons.person_pin_circle_rounded,
      secondaryIcon: Icons.directions_car_rounded,
    ),
    ProfessionalBanner(
      title: "Your Car. Your Choice.",
      subtitle:
          "Get dependable driver services for your personal vehicle.",
      buttonText: "Explore Service",
      icon: Icons.directions_car_filled_rounded,
      secondaryIcon: Icons.verified_user_rounded,
    ),
    ProfessionalBanner(
      title: "For Every Car Owner",
      subtitle:
          "Convenient driver solutions designed around your needs.",
      buttonText: "Get Started",
      icon: Icons.supervisor_account_rounded,
      secondaryIcon: Icons.car_rental_rounded,
    ),
    ProfessionalBanner(
      title: "Drive With Confidence",
      subtitle:
          "Professional service, trusted drivers and better journeys.",
      buttonText: "Learn More",
      icon: Icons.shield_rounded,
      secondaryIcon: Icons.drive_eta_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (!_pageController.hasClients) return;

        int nextPage = _currentPage + 1;

        if (nextPage >= banners.length) {
          nextPage = 0;
        }

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 215,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: _AnimatedBannerCard(
                  banner: banners[index],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 13),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) {
              final bool active =
                  index == _currentPage;

              return AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300),
                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                width: active ? 25 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.maroon
                      : const Color(0xFFD9D9DE),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================
// ANIMATED BANNER CARD
// ============================================================

class _AnimatedBannerCard extends StatefulWidget {
  final ProfessionalBanner banner;

  const _AnimatedBannerCard({
    required this.banner,
  });

  @override
  State<_AnimatedBannerCard> createState() =>
      _AnimatedBannerCardState();
}

class _AnimatedBannerCardState
    extends State<_AnimatedBannerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1600),
    )..repeat(
        reverse: true,
      );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.maroon,
            AppColors.maroonDark,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color:
                AppColors.maroon.withOpacity(0.20),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // DECORATIVE CIRCLE
          Positioned(
            right: -60,
            top: -70,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: -35,
            bottom: -75,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.14),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "BRD PREMIUM SERVICE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight:
                                FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        widget.banner.title,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          height: 1.08,
                          fontWeight:
                              FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        widget.banner.subtitle,
                        maxLines: 3,
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(0.78),
                          fontSize: 11.5,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 13),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.banner.buttonText,
                          style: const TextStyle(
                            color: AppColors.maroon,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // ANIMATED PERSON / CAR ILLUSTRATION
                Expanded(
                  flex: 4,
                  child: AnimatedBuilder(
                    animation:
                        _scaleAnimation,
                    builder:
                        (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: Container(
                      height: 145,
                      width: 125,
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.10),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white
                              .withOpacity(0.13),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            widget.banner.icon,
                            color: Colors.white,
                            size: 72,
                          ),

                          Positioned(
                            bottom: 22,
                            right: 9,
                            child: Container(
                              padding:
                                  const EdgeInsets.all(
                                10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(
                                      0.15,
                                    ),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                widget.banner
                                    .secondaryIcon,
                                color:
                                    AppColors.maroon,
                                size: 25,
                              ),
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
        ],
      ),
    );
  }
}

// ============================================================
// SERVICE CATEGORIES
// ============================================================

class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    const services = [
      _ServiceItem(
        icon: Icons.person_search_rounded,
        title: "Find Driver",
      ),
      _ServiceItem(
        icon: Icons.directions_car_rounded,
        title: "My Vehicle",
      ),
      _ServiceItem(
        icon: Icons.event_available_rounded,
        title: "Bookings",
      ),
      _ServiceItem(
        icon: Icons.receipt_long_rounded,
        title: "Payments",
      ),
    ];

    return Padding(
      padding:
          const EdgeInsets.fromLTRB(20, 25, 20, 8),
      child: Column(
        children: [
          const SectionHeader(
            title: "Our Services",
            subtitle: "Everything you need in one place",
          ),

          const SizedBox(height: 16),

          Row(
            children: services.map(
              (service) {
                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 9),
                    child: ServiceCard(
                      item: service,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final IconData icon;
  final String title;

  const _ServiceItem({
    required this.icon,
    required this.title,
  });
}

class ServiceCard extends StatelessWidget {
  final _ServiceItem item;

  const ServiceCard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.softMaroon,
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: Icon(
              item.icon,
              color: AppColors.maroon,
              size: 25,
            ),
          ),

          const SizedBox(height: 9),

          Text(
            item.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// QUICK SERVICES
// ============================================================

class QuickServices extends StatelessWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Column(
        children: [
          const SectionHeader(
            title: "Quick Access",
            subtitle: "Manage your driver service",
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: QuickServiceCard(
                  icon: Icons.history_rounded,
                  title: "Service History",
                  subtitle: "View previous services",
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: QuickServiceCard(
                  icon: Icons.star_rounded,
                  title: "My Reviews",
                  subtitle: "Ratings & feedback",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const QuickServiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.softMaroon,
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.maroon,
              size: 23,
            ),
          ),

          const SizedBox(width: 11),

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
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                    height: 1.3,
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

// ============================================================
// STATISTICS
// ============================================================

class ServiceStats extends StatelessWidget {
  const ServiceStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.fromLTRB(20, 18, 20, 0),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColors.maroon,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          Expanded(
            child: StatItem(
              icon: Icons.verified_rounded,
              value: "100%",
              label: "Trusted",
            ),
          ),
          VerticalDivider(
            color: Colors.white24,
            thickness: 1,
            width: 1,
          ),
          Expanded(
            child: StatItem(
              icon: Icons.people_alt_rounded,
              value: "24/7",
              label: "Support",
            ),
          ),
          VerticalDivider(
            color: Colors.white24,
            thickness: 1,
            width: 1,
          ),
          Expanded(
            child: StatItem(
              icon: Icons.speed_rounded,
              value: "Fast",
              label: "Service",
            ),
          ),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatItem({
    required this.icon,
    required this.value,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 21,
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SECTION HEADER
// ============================================================

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.softMaroon,
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.maroon,
            size: 13,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// BOTTOM NAVIGATION
// ============================================================

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Usergetxcontroller controller =
        Get.find<Usergetxcontroller>();

    return Obx(
      () {
        final int selectedIndex =
            controller.currentIndex.value;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: NavigationBar(
            height: 72,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedIndex: selectedIndex,
            indicatorColor: AppColors.softMaroon,
            labelBehavior:
                NavigationDestinationLabelBehavior
                    .alwaysShow,
            onDestinationSelected:
                (int index) {
              controller.currentIndex.value =
                  index;

              // EXISTING FUNCTIONALITY PRESERVED
              controller.box.write(
                'currentIndex',
                index,
              );
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home_rounded,
                  color: AppColors.maroon,
                ),
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.secondaryText,
                ),
                label: "Home",
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.person_rounded,
                  color: AppColors.maroon,
                ),
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.secondaryText,
                ),
                label: "Profile",
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.settings_rounded,
                  color: AppColors.maroon,
                ),
                icon: Icon(
                  Icons.settings_outlined,
                  color: AppColors.secondaryText,
                ),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// HIRE / BILLING MANAGEMENT
// ============================================================

class UserHireManagementCard extends StatelessWidget {
  const UserHireManagementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Driver Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 6),
            const Text('Manage hire offers, your active driver service and monthly billing.', style: TextStyle(color: AppColors.secondaryText)),
            const SizedBox(height: 14),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _ManagementButton(icon: Icons.notifications_none_rounded, label: 'Hire Offers', onTap: () => Get.toNamed(Routers.NOTIFICATIONS)),
              _ManagementButton(icon: Icons.directions_car_filled_rounded, label: 'My Service', onTap: () => Get.toNamed(Routers.MY_DRIVER_SERVICE)),
              _ManagementButton(icon: Icons.history_rounded, label: 'Service History', onTap: () => Get.toNamed(Routers.USER_SERVICE_HISTORY)),
              _ManagementButton(icon: Icons.location_on_outlined, label: 'Live Driver Location', onTap: () => Get.toNamed(Routers.USER_SERVICE_HISTORY)),
              _ManagementButton(icon: Icons.receipt_long_rounded, label: 'Billing', onTap: () => Get.toNamed(Routers.MY_BILLING)),
              _ManagementButton(icon: Icons.history_rounded, label: 'Transactions', onTap: () => Get.toNamed(Routers.MY_TRANSACTIONS)),
            ]),
          ],
        ),
      ),
    );
  }
}

class _ManagementButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ManagementButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(onPressed: onTap, icon: Icon(icon, size: 18), label: Text(label));
}
