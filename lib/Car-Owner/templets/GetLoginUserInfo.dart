import 'package:brd/Car-Owner/templets/UserSignUp.dart';
import 'package:brd/Driver/DriverRegistration.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Getloginuserinfo extends StatelessWidget {
  const Getloginuserinfo({super.key});

  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5C0000);
  static const Color maroonLight = Color(0xFF9E1B32);

  static const Color background = Color(0xFFF8F8F8);
  static const Color surface = Colors.white;
  static const Color inputBackground = Color(0xFFF7F7F9);

  static const Color ink = Color(0xFF1A1A1A);
  static const Color sub = Color(0xFF6B7280);
  static const Color line = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final Usergetxcontroller controller =
        Get.put(Usergetxcontroller());

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(context),

              Transform.translate(
                offset: const Offset(0, -24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildLoginCard(controller),
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -16),
                child: _buildSecuritySection(),
              ),

              Transform.translate(
                offset: const Offset(0, -4),
                child: const NoAccountText(),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 72),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            maroon,
            maroonDark,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -45,
            right: -40,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          Positioned(
            bottom: -80,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.18),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.16),
                      ),
                    ),
                    child: Text(
                      "ACCOUNT ACCESS",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 38),

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock_person_rounded,
                  color: maroon,
                  size: 30,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Welcome back",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Enter your registered email or phone number\nto continue securely.",
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 14,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(
    Usergetxcontroller controller,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: line,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 28,
                decoration: BoxDecoration(
                  color: maroon,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign in to your account",
                      style: GoogleFonts.inter(
                        color: ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      "Use your registered information",
                      style: GoogleFonts.inter(
                        color: sub,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          ForgotPasswordForm(
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _securityItem(
            icon: Icons.verified_user_rounded,
            title: "Secure",
            subtitle: "Protected",
          ),

          const SizedBox(width: 10),

          _securityItem(
            icon: Icons.bolt_rounded,
            title: "Fast",
            subtitle: "Instant",
          ),

          const SizedBox(width: 10),

          _securityItem(
            icon: Icons.privacy_tip_rounded,
            title: "Private",
            subtitle: "Confidential",
          ),
        ],
      ),
    );
  }

  Widget _securityItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: line,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: maroon.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: maroon,
                size: 19,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: GoogleFonts.inter(
                color: ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: sub,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// FORM
// ============================================================

class ForgotPasswordForm extends StatelessWidget {
  final Usergetxcontroller controller;

  const ForgotPasswordForm({
    super.key,
    required this.controller,
  });

  static const Color maroon = Color(0xFF800000);
  static const Color background = Color(0xFFF7F7F9);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color sub = Color(0xFF6B7280);
  static const Color line = Color(0xFFE5E7EB);

  OutlineInputBorder _border({
    Color color = line,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [

          Text(
            "Email or phone number",
            style: GoogleFonts.inter(
              color: ink,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 9),

          Obx(
            () => TextFormField(
              controller:
                  controller.userinfoController,

              onChanged:
                  controller.changeInfoPromt,

              keyboardType:
                  TextInputType.emailAddress,

              style: GoogleFonts.inter(
                color: ink,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),

              decoration: InputDecoration(
                hintText:
                    "Enter email or phone number",

                hintStyle: GoogleFonts.inter(
                  color: sub.withOpacity(0.75),
                  fontSize: 13,
                ),

                filled: true,

                fillColor: background,

                prefixIcon: Container(
                  margin: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: maroon.withOpacity(0.08),
                    borderRadius:
                        BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: maroon,
                    size: 20,
                  ),
                ),

                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                border: _border(),

                enabledBorder: _border(),

                focusedBorder: _border(
                  color: maroon,
                  width: 1.5,
                ),

                errorBorder: _border(
                  color: Colors.red.shade700,
                  width: 1.2,
                ),

                focusedErrorBorder: _border(
                  color: Colors.red.shade700,
                  width: 1.5,
                ),

                errorText:
                    controller.error.value.isEmpty
                        ? null
                        : controller.error.value,

                errorStyle: GoogleFonts.inter(
                  color: Colors.red.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Obx(() {
            final bool loading =
                controller.isLoading.value;

            return SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        String userinfo =
                            controller
                                .userinfoController
                                .text
                                .trim();

                        if (userinfo.isEmpty) {
                          controller.error.value =
                              "Please enter phone or email";
                          return;
                        }

                        // Existing backend functionality
                        // remains unchanged.
                        controller.submitform(
                          userinfo,
                        );
                      },

                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  backgroundColor: maroon,

                  disabledBackgroundColor:
                      maroon.withOpacity(0.55),

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  shadowColor:
                      maroon.withOpacity(0.35),
                ),

                child: loading
                    ? const SizedBox(
                        width: 23,
                        height: 23,
                        child:
                            CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continue",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),

                          const SizedBox(width: 9),

                          const Icon(
                            Icons
                                .arrow_forward_rounded,
                            size: 20,
                          ),
                        ],
                      ),
              ),
            );
          }),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline_rounded,
                size: 13,
                color: sub,
              ),

              const SizedBox(width: 5),

              Text(
                "Your information is securely protected",
                style: GoogleFonts.inter(
                  color: sub,
                  fontSize: 11,
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
// CREATE ACCOUNT SECTION
// ============================================================

class NoAccountText extends StatelessWidget {
  const NoAccountText({super.key});

  static const Color maroon = Color(0xFF800000);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color sub = Color(0xFF6B7280);
  static const Color line = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Don't have an account?",
          style: GoogleFonts.inter(
            color: sub,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 10),

        InkWell(
          onTap: () => _showSignupSheet(
            context,
          ),
          borderRadius:
              BorderRadius.circular(14),

          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 11,
            ),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(14),

              border: Border.all(
                color: line,
              ),
            ),

            child: Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: maroon,
                  size: 18,
                ),

                const SizedBox(width: 8),

                Text(
                  "Create an account",
                  style: GoogleFonts.inter(
                    color: maroon,
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSignupSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,

      backgroundColor:
          Colors.transparent,

      isScrollControlled: true,

      builder: (_) {
        return Container(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            14,
            20,
            30,
          ),

          decoration: const BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Center(
                child: Container(
                  width: 46,
                  height: 5,

                  decoration: BoxDecoration(
                    color: line,

                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              Container(
                width: 52,
                height: 52,

                decoration: BoxDecoration(
                  color:
                      maroon.withOpacity(0.08),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Icon(
                  Icons
                      .account_circle_outlined,
                  color: maroon,
                  size: 28,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                "Create your account",
                style: GoogleFonts.inter(
                  color: ink,
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                "Choose how you would like to use the platform.",
                style: GoogleFonts.inter(
                  color: sub,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              _roleTile(
                icon:
                    Icons.directions_car_filled_rounded,

                title: "Driver",

                subtitle:
                    "Register as a professional driver",

                onTap: () {
                  Get.back();

                  Get.to(
                    () => Driverregistration(),
                  );
                },
              ),

              const SizedBox(height: 14),

              _roleTile(
                icon:
                    Icons.person_pin_circle_rounded,

                title: "Car Owner",

                subtitle:
                    "Manage your vehicles and services",

                onTap: () {
                  Get.back();

                  Get.to(
                    () => Usersignup(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _roleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(18),

        child: Container(
          padding:
              const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color:
                const Color(0xFFF7F7F9),

            borderRadius:
                BorderRadius.circular(18),

            border: Border.all(
              color: line,
            ),
          ),

          child: Row(
            children: [

              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: maroon,

                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
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

                      style:
                          GoogleFonts.inter(
                        color: ink,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,

                      style:
                          GoogleFonts.inter(
                        color: sub,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 36,
                height: 36,

                decoration: BoxDecoration(
                  color:
                      maroon.withOpacity(0.08),

                  borderRadius:
                      BorderRadius.circular(11),
                ),

                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: maroon,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}