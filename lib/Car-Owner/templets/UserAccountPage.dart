import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';

class Useraccountpage extends StatelessWidget {
  Useraccountpage({super.key});

  final Usergetxcontroller controller =
      Get.find<Usergetxcontroller>();

  static const Color maroon =
      Color(0xFF800000);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bool darkMode =
            controller.IsDarkMode.value;

        final Color backgroundColor =
            darkMode
                ? const Color(0xFF121212)
                : const Color(0xFFF6F7FB);

        final Color cardColor =
            darkMode
                ? const Color(0xFF1E1E1E)
                : Colors.white;

        final Color primaryText =
            darkMode
                ? Colors.white
                : Colors.black87;

        final Color secondaryText =
            darkMode
                ? Colors.grey.shade400
                : Colors.grey.shade600;

        final Color dividerColor =
            darkMode
                ? Colors.white.withOpacity(0.08)
                : maroon.withOpacity(0.08);

        return Scaffold(
          backgroundColor:
              backgroundColor,

          // ====================================================
          // APP BAR
          // ====================================================

          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: maroon,

            title: const Text(
              "Account Settings",
              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),

            shape:
                const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(
                bottom:
                    Radius.circular(18),
              ),
            ),
          ),

          // ====================================================
          // BODY
          // ====================================================

          body: SingleChildScrollView(
            padding:
                const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 10),

                Text(
                  "Manage your preferences",
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        secondaryText,
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // SETTINGS CARD
                // ==================================================

                _SettingsCard(
                  isDarkMode:
                      darkMode,

                  children: [
                    ProfileMenuCard(
                      svgSrc:
                          profileIconSvg,
                      title:
                          "Profile Information",
                      subTitle:
                          "Update your personal details",
                      press: () {},
                      isDarkMode:
                          darkMode,
                    ),

                    Divider(
                      height: 1,
                      color:
                          dividerColor,
                    ),

                    ProfileMenuCard(
                      svgSrc:
                          lockIconSvg,
                      title:
                          "Change Password",
                      subTitle:
                          "Secure your account",
                      press: () {},
                      isDarkMode:
                          darkMode,
                    ),

                    Divider(
                      height: 1,
                      color:
                          dividerColor,
                    ),

                    ProfileMenuCard(
                      svgSrc:
                          cardIconSvg,
                      title:
                          "Payment Methods",
                      subTitle:
                          "Cards & billing options",
                      press: () {},
                      isDarkMode:
                          darkMode,
                    ),

                    Divider(
                      height: 1,
                      color:
                          dividerColor,
                    ),

                    ProfileMenuCard(
                      svgSrc:
                          markerIconSvg,
                      title:
                          "Saved Locations",
                      subTitle:
                          "Manage your addresses",
                      press: () {},
                      isDarkMode:
                          darkMode,
                    ),

                    Divider(
                      height: 1,
                      color:
                          dividerColor,
                    ),

                    // ==============================================
                    // DARK MODE
                    // ==============================================

                    _DarkModeTile(
                      controller:
                          controller,
                      darkMode:
                          darkMode,
                      primaryText:
                          primaryText,
                      secondaryText:
                          secondaryText,
                    ),

                    Divider(
                      height: 1,
                      color:
                          dividerColor,
                    ),

                    ProfileMenuCard(
                      svgSrc:
                          shareIconSvg,
                      title:
                          "Refer Friends",
                      subTitle:
                          "Invite & earn rewards",
                      press: () {},
                      isDarkMode:
                          darkMode,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ==================================================
                // SECURITY INFO
                // ==================================================

                _SecurityInfoCard(
                  darkMode:
                      darkMode,
                  cardColor:
                      cardColor,
                  secondaryText:
                      secondaryText,
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// DARK MODE TILE
// ============================================================

class _DarkModeTile
    extends StatelessWidget {
  const _DarkModeTile({
    required this.controller,
    required this.darkMode,
    required this.primaryText,
    required this.secondaryText,
  });

  final Usergetxcontroller controller;

  final bool darkMode;

  final Color primaryText;

  final Color secondaryText;

  static const Color maroon =
      Color(0xFF800000);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),

      child: Row(
        children: [
          // ==================================================
          // ICON
          // ==================================================

          Container(
            padding:
                const EdgeInsets.all(10),

            decoration:
                BoxDecoration(
              color:
                  maroon.withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              darkMode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,

              color: maroon,

              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          // ==================================================
          // TEXT
          // ==================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        primaryText,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  darkMode
                      ? "Dark theme is enabled"
                      : "Light theme is enabled",

                  style: TextStyle(
                    fontSize: 13,
                    color:
                        secondaryText,
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // SWITCH
          // ==================================================

          Switch(
            value:
                controller
                    .IsDarkMode
                    .value,

            activeColor:
                maroon,

            onChanged:
                (bool value) {
              controller
                  .toggleDarkMode(
                value,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SETTINGS CARD
// ============================================================

class _SettingsCard
    extends StatelessWidget {
  const _SettingsCard({
    required this.children,
    required this.isDarkMode,
  });

  final List<Widget> children;

  final bool isDarkMode;

  @override
  Widget build(
    BuildContext context,
  ) {
    final Color background =
        isDarkMode
            ? const Color(0xFF1E1E1E)
            : Colors.white;

    // IMPORTANT:
    // Material is placed around the card.
    //
    // This prevents the Flutter assertion:
    //
    // "ListTile background color or ink splashes may be invisible."
    //
    // because Material now handles the ink effects.

    return Material(
      color: background,

      borderRadius:
          BorderRadius.circular(18),

      clipBehavior:
          Clip.antiAlias,

      elevation: 0,

      child: Container(
        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(
                isDarkMode
                    ? 0.25
                    : 0.06,
              ),
              blurRadius: 16,
              offset:
                  const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          children: children,
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE MENU CARD
// ============================================================

class ProfileMenuCard
    extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    this.title,
    this.subTitle,
    this.svgSrc,
    this.press,
    required this.isDarkMode,
  });

  final String? title;

  final String? subTitle;

  final String? svgSrc;

  final VoidCallback? press;

  final bool isDarkMode;

  static const Color maroon =
      Color(0xFF800000);

  @override
  Widget build(
    BuildContext context,
  ) {
    final Color primaryText =
        isDarkMode
            ? Colors.white
            : Colors.black87;

    final Color secondaryText =
        isDarkMode
            ? Colors.grey.shade400
            : Colors.grey.shade600;

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: press,

        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),

          child: Row(
            children: [
              // ================================================
              // SVG ICON
              // ================================================

              Container(
                padding:
                    const EdgeInsets.all(10),

                decoration:
                    BoxDecoration(
                  color:
                      maroon.withOpacity(0.10),

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: SvgPicture.string(
                  svgSrc!,
                  height: 22,
                  width: 22,

                  colorFilter:
                      const ColorFilter.mode(
                    maroon,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // ================================================
              // TEXT
              // ================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      title!,

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            primaryText,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subTitle!,

                      style: TextStyle(
                        fontSize: 13,
                        color:
                            secondaryText,
                      ),
                    ),
                  ],
                ),
              ),

              // ================================================
              // ARROW
              // ================================================

              Container(
                padding:
                    const EdgeInsets.all(6),

                decoration:
                    BoxDecoration(
                  color:
                      maroon.withOpacity(0.08),
                  shape:
                      BoxShape.circle,
                ),

                child: const Icon(
                  Icons
                      .arrow_forward_ios_rounded,
                  size: 14,
                  color: maroon,
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
// SECURITY INFO
// ============================================================

class _SecurityInfoCard
    extends StatelessWidget {
  const _SecurityInfoCard({
    required this.darkMode,
    required this.cardColor,
    required this.secondaryText,
  });

  final bool darkMode;

  final Color cardColor;

  final Color secondaryText;

  static const Color maroon =
      Color(0xFF800000);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: cardColor,

      borderRadius:
          BorderRadius.circular(16),

      child: Container(
        padding:
            const EdgeInsets.all(14),

        decoration:
            BoxDecoration(
          borderRadius:
              BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(
                darkMode
                    ? 0.20
                    : 0.05,
              ),

              blurRadius: 12,

              offset:
                  const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(9),

              decoration:
                  BoxDecoration(
                color:
                    maroon.withOpacity(0.10),

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons
                    .info_outline_rounded,
                color: maroon,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                "Keep your account secure by updating settings regularly.",

                style: TextStyle(
                  color:
                      secondaryText,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SVG ICONS
// ============================================================

const profileIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M8.66667 7.83333C8.66667 9.67428 10.1591 11.1667 12 11.1667C13.8409 11.1667 15.3333 9.67428 15.3333 7.83333C15.3333 5.99238 13.8409 4.5 12 4.5C10.1591 4.5 8.66667 5.99238 8.66667 7.83333ZM11.9861 12.8333C8.05159 12.8333 4.82355 14.8554 4.50054 18.8327C4.48295 19.0493 4.89726 19.5 5.10625 19.5H18.8722C19.4983 19.5 19.508 18.9962 19.4983 18.8333C19.2541 14.7443 15.976 12.8333 11.9861 12.8333Z" fill="#010F07"/>
</svg>
''';

const lockIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M17 10C18.1046 10 19 10.8954 19 12V18C19 19.1046 18.1046 20 17 20H7C5.89543 20 5 19.1046 5 18V12C5 10.8954 5.89543 10 7 10V9C7 6.23858 9.23858 4 12 4C14.7614 4 17 6.23858 17 9V10ZM12 6C10.3431 6 9 7.34315 9 9V10H15V9C15 7.34315 13.6569 6 12 6Z" fill="#010F07"/>
</svg>
''';

const cardIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M3.66669 7.83334C3.66669 6.91287 4.41288 6.16667 5.33335 6.16667H18.6667C19.5872 6.16667 20.3334 6.91286 20.3334 7.83334V8.66667H3.66669V7.83334ZM3.66669 11.1667H20.3334V16.1667C20.3334 17.0871 19.5872 17.8333 18.6667 17.8333H5.33335C4.41288 17.8333 3.66669 17.0871 3.66669 16.1667V11.1667ZM16.1667 13.6667C15.7065 13.6667 15.3334 14.0398 15.3334 14.5C15.3334 14.9602 15.7064 15.3333 16.1667 15.3333H17.8334C18.2936 15.3333 18.6667 14.9602 18.6667 14.5C18.6667 14.0398 18.2936 13.6667 17.8334 13.6667H16.1667Z" fill="#010F07"/>
</svg>
''';

const markerIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M6.16666 10.75C6.16666 7 8.66666 4.5 12.4167 4.5C16.1667 4.5 18.6667 7.625 18.6667 10.75C18.6667 12.6938 16.853 15.3631 13.2258 18.7577C12.7628 19.191 12.0487 19.209 11.5645 18.7996C7.96595 15.7565 6.16666 13.0733 6.16666 10.75ZM12.4167 12C13.5672 12 14.5 11.0673 14.5 9.91667C14.5 8.76607 13.5672 7.83333 12.4167 7.83333C11.2661 7.83333 10.3333 8.76607 10.3333 9.91667C10.3333 11.0673 11.2661 12 12.4167 12Z" fill="#010F07"/>
</svg>
''';

const shareIconSvg = '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M7.62683 13.6939C7.6272 13.7341 7.62753 13.7697 7.62753 13.8006C7.62753 13.9503 7.62676 14.1578 7.62596 14.3719C7.62512 14.5999 7.62424 14.8354 7.62424 15.0163H7.74443C7.97199 15.0163 8.17547 14.8667 8.25435 14.6414C8.92315 12.731 9.86818 11.5708 11.0894 11.1607C11.9413 10.8746 12.879 10.7862 14.1953 10.748V13.7028C14.1953 13.8474 14.247 13.9866 14.3401 14.0927C14.5441 14.3252 14.888 14.3392 15.1083 14.1238L19.8257 9.51233C20.0607 9.24216 20.044 8.87926 19.8216 8.66632L15.1042 4.14884C15.0042 4.05306 14.874 4 14.7389 4C14.4387 4 14.1953 4.25691 14.1953 4.57383V7.54677C12.1221 7.64403 10.3885 7.85731 9.23015 9.08696C7.6001 10.8174 7.62014 12.9747 7.62683 13.6939ZM11.176 5.46295C11.176 5.04039 10.8515 4.69784 10.4511 4.69784H6.89939C5.2981 4.69784 4 6.06804 4 7.75827V16.9396C4 18.6298 5.2981 20 6.89939 20H15.5976C17.1989 20 18.497 18.6298 18.497 16.9396V15.4094C18.497 14.9868 18.1724 14.6442 17.7721 14.6442C17.3718 14.6442 17.0473 14.9868 17.0473 15.4094V16.9396C17.0473 17.7847 16.3982 18.4698 15.5976 18.4698H6.89939C6.09875 18.4698 5.4497 17.7847 5.4497 16.9396V7.75827C5.4497 6.91316 6.09875 6.22806 6.89939 6.22806H10.4511C10.8515 6.22806 11.176 5.88551 11.176 5.46295Z" fill="#010F07"/>
</svg>
''';