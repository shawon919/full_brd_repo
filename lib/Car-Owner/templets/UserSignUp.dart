import 'package:brd/Car-Owner/templets/GetLoginUserInfo.dart';
import 'package:brd/Car-Owner/templets/UserMobileOTPVarification.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Usersignup extends StatelessWidget {
  Usersignup({super.key});

  static const Color maroon = Color(0xFF800000);
  static const Color darkMaroon = Color(0xFF5C0000);
  static const Color lightMaroon = Color(0xFFFFF5F5);
  static const Color background = Color(0xFFF7F7F9);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color borderGrey = Color(0xFFE2E4E8);

  final Usergetxcontroller controller = Get.find();

  // ============================================================
  // HEADER
  // ============================================================

  Widget buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            maroon,
            darkMaroon,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
      ),
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            right: -70,
            top: -65,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          // Decorative circle
          Positioned(
            left: -85,
            bottom: -105,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.045),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              34,
            ),
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
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.13),
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
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'Create your account',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Register your account and get started with BRD.',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.82),
                    fontSize: 13.5,
                    height: 1.4,
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
  // MAIN PAGE
  // ============================================================

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
                  16,
                  24,
                  16,
                  30,
                ),
                child: Column(
                  children: [
                    // Information header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: lightMaroon,
                              borderRadius:
                                  BorderRadius.circular(13),
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: maroon,
                              size: 23,
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
                                    color: textDark,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Enter your details to create an account.',
                                  style: GoogleFonts.inter(
                                    color: textGrey,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    SignUpForm(),

                    const SizedBox(height: 20),

                    const AlreadyAccountText(),

                    const SizedBox(height: 18),

                    Text(
                      'BRD • Car Owner & Driver Services',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade500,
                        fontSize: 10.5,
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
    color: Color(0xFFE0E1E5),
    width: 1,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(14),
  ),
);

// ============================================================
// SIGN UP FORM
// ============================================================

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  final Usergetxcontroller controller = Get.find();

  final RxBool isPasswordHidden = true.obs;

  final RxBool isConfirmHidden = true.obs;

  // ============================================================
  // INPUT DECORATION
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

      floatingLabelBehavior:
          FloatingLabelBehavior.always,

      prefixIcon: Icon(
        icon,
        color: const Color(0xFF800000),
        size: 20,
      ),

      suffixIcon: suffixIcon,

      labelStyle: GoogleFonts.inter(
        color: const Color(0xFF800000),
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
      ),

      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF9A9CA2),
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
  // ============================================================

  Widget errorText(RxString error) {
    return Obx(
      () {
        if (error.value.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 5,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 13,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    error.value,
                    style: GoogleFonts.inter(
                      color: Colors.red.shade700,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget sectionLabel(
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF800000),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.only(
              left: 14,
            ),
            child: Text(
              subtitle,
              style: GoogleFonts.inter(
                color: const Color(0xFF777777),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FORM
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        22,
        18,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE5E6EA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          sectionLabel(
            'Account Details',
            'Please provide the information below.',
          ),

          // ======================================================
          // FULL NAME
          // ======================================================

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

          // ======================================================
          // EMAIL
          // ======================================================

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
              hint: 'Enter your email address',
              icon: Icons.email_outlined,
            ),
          ),

          errorText(
            controller.emailError,
          ),

          const SizedBox(height: 18),

          // ======================================================
          // PHONE
          // ======================================================

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

          // ======================================================
          // PASSWORD
          // ======================================================

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
                    onPressed: () {
                      isPasswordHidden.value =
                          !isPasswordHidden.value;
                    },
                    icon: Icon(
                      isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          ),

          errorText(
            controller.passwordError,
          ),

          const SizedBox(height: 18),

          // ======================================================
          // CONFIRM PASSWORD
          // ======================================================

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
                    onPressed: () {
                      isConfirmHidden.value =
                          !isConfirmHidden.value;
                    },
                    icon: Icon(
                      isConfirmHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          ),

          errorText(
            controller.confirmPasswordError,
          ),

          const SizedBox(height: 25),

          // ======================================================
          // SIGN UP BUTTON
          // ======================================================

          Obx(
            () {
              final bool loading =
                  controller.isLoading.value;

              return SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  // EXISTING BACKEND METHOD
                  onPressed: loading
                      ? null
                      : () {
                          controller.userRegistration();
                        },

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        const Color(0xFF800000),
                    disabledBackgroundColor:
                        const Color(0xFFB78A8A),
                    foregroundColor:
                        Colors.white,
                    disabledForegroundColor:
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
                            key: ValueKey(
                              'loading',
                            ),
                            height: 22,
                            width: 22,
                            child:
                                CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.3,
                            ),
                          )
                        : Row(
                            key: const ValueKey(
                              'button',
                            ),
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style:
                                    GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),

                              const SizedBox(width: 9),

                              const Icon(
                                Icons
                                    .arrow_forward_rounded,
                                color: Colors.white,
                                size: 19,
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          // Security information
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FA),
              borderRadius:
                  BorderRadius.circular(11),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.grey.shade500,
                  size: 14,
                ),

                const SizedBox(width: 6),

                Flexible(
                  child: Text(
                    'Your information is securely protected',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade500,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
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
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E6EA),
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

          const SizedBox(width: 6),

          GestureDetector(
            onTap: () {
              // EXISTING NAVIGATION
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