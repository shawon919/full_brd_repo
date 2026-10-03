import 'package:brd/Car-Owner/templets/GetLoginUserInfo.dart';
import 'package:brd/Car-Owner/templets/UserMobileOTPVarification.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Usersignup extends StatelessWidget {
  Usersignup({super.key});

  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5C0000);
  static const Color maroonLight = Color(0xFFF9EEEE);
  static const Color background = Color(0xFFF8F8FA);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF707070);
  static const Color border = Color(0xFFE2E2E7);

  final Usergetxcontroller controller = Get.find();

  // ============================================================
  // HEADER UI ONLY
  // ============================================================

  Widget buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
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
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Material(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => Get.back(),
                child: const SizedBox(
                  height: 44,
                  width: 44,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Small badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'USER REGISTRATION',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Create your account',
              style: GoogleFonts.inter(
                fontSize: 29,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.15,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Join BRD and start your journey with us.',
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.82),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              buildHeader(context),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  22,
                  18,
                  30,
                ),
                child: Column(
                  children: [
                    // Intro section
                    Row(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: maroonLight,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.person_outline_rounded,
                            color: maroon,
                            size: 22,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal Information',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textDark,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Fill in your details to continue',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Signup form
                    SignUpForm(),

                    const SizedBox(height: 22),

                    const AlreadyAccountText(),

                    const SizedBox(height: 10),

                    // Bottom branding
                    Text(
                      'BRD • Car Owner & Driver Services',
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
// INPUT BORDER
// ============================================================

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xFFD9D9DF),
    width: 1,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(14),
  ),
);

// ============================================================
// SIGNUP FORM
// ============================================================

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  final Usergetxcontroller controller = Get.find();

  final RxBool isPasswordHidden = true.obs;

  final RxBool isConfirmHidden = true.obs;

  // ============================================================
  // INPUT DECORATION
  // UI ONLY
  // ============================================================

  InputDecoration inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF800000),
        size: 20,
      ),
      suffixIcon: suffixIcon,

      floatingLabelBehavior:
          FloatingLabelBehavior.always,

      labelStyle: GoogleFonts.inter(
        color: const Color(0xFF800000),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),

      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF9A9A9A),
        fontSize: 13,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border: authOutlineInputBorder,

      enabledBorder: authOutlineInputBorder,

      focusedBorder: authOutlineInputBorder.copyWith(
        borderSide: const BorderSide(
          color: Color(0xFF800000),
          width: 1.6,
        ),
      ),

      errorBorder: authOutlineInputBorder.copyWith(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.2,
        ),
      ),

      focusedErrorBorder:
          authOutlineInputBorder.copyWith(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // ERROR TEXT
  // UI ONLY
  // ============================================================

  Widget errorText(RxString error) {
    return Obx(
      () {
        if (error.value.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(
            left: 4,
            top: 5,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              error.value,
              style: GoogleFonts.inter(
                color: Colors.red.shade700,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // SECTION LABEL
  // ============================================================

  Widget sectionLabel(
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        20,
        18,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE6E6EA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        children: [
          sectionLabel(
            'Account Details',
            'Enter your information below.',
          ),

          // ====================================================
          // FULL NAME
          // ====================================================

          TextFormField(
            controller:
                controller.fullnameController,

            onChanged:
                controller.fullnameValidation,

            textInputAction:
                TextInputAction.next,

            decoration: inputDecoration(
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline_rounded,
            ),
          ),

          errorText(
            controller.fullnameError,
          ),

          const SizedBox(height: 18),

          // ====================================================
          // EMAIL
          // ====================================================

          TextFormField(
            controller:
                controller.emailController,

            onChanged:
                controller.emailValidation,

            keyboardType:
                TextInputType.emailAddress,

            textInputAction:
                TextInputAction.next,

            decoration: inputDecoration(
              label: 'Email Address',
              hint: 'Enter your email',
              icon: Icons.email_outlined,
            ),
          ),

          errorText(
            controller.emailError,
          ),

          const SizedBox(height: 18),

          // ====================================================
          // PHONE
          // ====================================================

          TextFormField(
            controller:
                controller.phoneController,

            onChanged:
                controller.phoneValidation,

            keyboardType:
                TextInputType.phone,

            textInputAction:
                TextInputAction.next,

            decoration: inputDecoration(
              label: 'Phone Number',
              hint: 'Enter your phone number',
              icon: Icons.phone_outlined,
            ),
          ),

          errorText(
            controller.phoneError,
          ),

          const SizedBox(height: 18),

          // ====================================================
          // PASSWORD
          // ====================================================

          Obx(
            () {
              return TextFormField(
                controller:
                    controller.userpasswordController,

                onChanged:
                    controller.passwordValidation,

                obscureText:
                    isPasswordHidden.value,

                textInputAction:
                    TextInputAction.next,

                decoration: inputDecoration(
                  label: 'Password',
                  hint: 'Create a password',
                  icon: Icons.lock_outline_rounded,

                  suffixIcon: IconButton(
                    splashRadius: 22,
                    icon: Icon(
                      isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    onPressed: () {
                      isPasswordHidden.value =
                          !isPasswordHidden.value;
                    },
                  ),
                ),
              );
            },
          ),

          errorText(
            controller.passwordError,
          ),

          const SizedBox(height: 18),

          // ====================================================
          // CONFIRM PASSWORD
          // ====================================================

          Obx(
            () {
              return TextFormField(
                controller:
                    controller.confirmpasswordController,

                onChanged:
                    controller.confirmPasswordValidation,

                obscureText:
                    isConfirmHidden.value,

                textInputAction:
                    TextInputAction.done,

                decoration: inputDecoration(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  icon: Icons.lock_reset_outlined,

                  suffixIcon: IconButton(
                    splashRadius: 22,
                    icon: Icon(
                      isConfirmHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    onPressed: () {
                      isConfirmHidden.value =
                          !isConfirmHidden.value;
                    },
                  ),
                ),
              );
            },
          ),

          errorText(
            controller.confirmPasswordError,
          ),

          const SizedBox(height: 25),

          // ====================================================
          // SIGNUP BUTTON
          // ====================================================

          Obx(
            () {
              final loading =
                  controller.isLoading.value;

              return SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () {
                          // SAME BACKEND METHOD
                          controller.userRegistration();
                        },

                  style: ElevatedButton.styleFrom(
                    elevation: 0,

                    backgroundColor:
                        const Color(0xFF800000),

                    disabledBackgroundColor:
                        const Color(0xFFB98787),

                    foregroundColor:
                        Colors.white,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),

                  child: AnimatedSwitcher(
                    duration:
                        const Duration(
                      milliseconds: 200,
                    ),

                    child: loading
                        ? const SizedBox(
                            key: ValueKey('loading'),
                            height: 22,
                            width: 22,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            key: const ValueKey(
                              'signup',
                            ),
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style:
                                    GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.w700,
                                  color:
                                      Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              const Icon(
                                Icons
                                    .arrow_forward_rounded,
                                size: 19,
                                color:
                                    Colors.white,
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 14),

          // Security message
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 14,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 6),
              Text(
                'Your information is securely protected',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  color: Colors.grey.shade500,
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
// ALREADY HAVE ACCOUNT
// ============================================================

class AlreadyAccountText
    extends StatelessWidget {
  const AlreadyAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE7E7EB),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: GoogleFonts.inter(
              color: const Color(0xFF757575),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(width: 5),

          GestureDetector(
            onTap: () {
              // SAME NAVIGATION
              Get.to(
                Getloginuserinfo(),
              );
            },
            child: Text(
              'Sign In',
              style: GoogleFonts.inter(
                color: const Color(0xFF800000),
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}