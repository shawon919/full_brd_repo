import 'package:brd/Car-Owner/templets/GetLoginUserInfo.dart';
import 'package:brd/Car-Owner/templets/Submituser_info_form.dart';
import 'package:brd/Car-Owner/templets/UserSignUp.dart' as signup;
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ===============================================================
/// COLORS
/// ===============================================================

const Color maroon = Color(0xFF800000);
const Color darkMaroon = Color(0xFF5C0000);
const Color lightMaroon = Color(0xFFF8EAEA);

const Color pageBackground = Color(0xFFF7F7F9);
const Color cardWhite = Colors.white;

const Color textDark = Color(0xFF1A1A1A);
const Color textGrey = Color(0xFF6B7280);
const Color borderColor = Color(0xFFE2E4E8);

/// ===============================================================
/// USER SIGN IN
/// ===============================================================

class UserSignin extends StatelessWidget {
  const UserSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const LoginHeader(),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  24,
                  16,
                  32,
                ),
                child: Column(
                  children: [
                    const SignInForm(),

                    const SizedBox(height: 18),

                    const AccountText(),

                    const SizedBox(height: 20),

                    const NoAccountText(),
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

/// ===============================================================
/// LOGIN HEADER
/// ===============================================================

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        30,
      ),
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
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -65,
            top: -70,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Positioned(
            left: -70,
            bottom: -100,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.offAll(
                      () => Getloginuserinfo(),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "USER LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Sign in to your account and continue.",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ===============================================================
/// INPUT BORDER
/// ===============================================================

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: borderColor,
    width: 1.2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(14),
  ),
);

/// ===============================================================
/// SIGN IN FORM
/// ===============================================================

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Usergetxcontroller controller =
        Get.put(Usergetxcontroller());

    final args = Get.arguments ?? {};

    String username = args['username'] ?? "";
    String email = args['email'] ?? "";

    controller.userinfoController.text = email;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sign in to your account",
              style: TextStyle(
                color: textDark,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Enter your credentials below.",
              style: TextStyle(
                color: textGrey,
                fontSize: 12.5,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Email",
              style: TextStyle(
                color: textDark,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: controller.userinfoController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,

              // BACKEND METHOD UNCHANGED
              onChanged: controller.changeInfoPromt,

              decoration: InputDecoration(
                hintText: email.isNotEmpty
                    ? email
                    : "Enter your email",

                hintStyle: const TextStyle(
                  color: textGrey,
                  fontSize: 13,
                ),

                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: maroon,
                  size: 21,
                ),

                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),

                filled: true,
                fillColor: Colors.white,

                border: authOutlineInputBorder,

                enabledBorder:
                    authOutlineInputBorder,

                focusedBorder:
                    authOutlineInputBorder.copyWith(
                  borderSide: const BorderSide(
                    color: maroon,
                    width: 1.6,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Password",
              style: TextStyle(
                color: textDark,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Obx(
              () {
                return TextFormField(
                  controller:
                      controller.passwordController,

                  // BACKEND STATE UNCHANGED
                  obscureText:
                      controller.isHidden.value,

                  textInputAction:
                      TextInputAction.done,

                  decoration: InputDecoration(
                    hintText:
                        "Enter your password",

                    hintStyle:
                        const TextStyle(
                      color: textGrey,
                      fontSize: 13,
                    ),

                    prefixIcon:
                        const Icon(
                      Icons.lock_outline_rounded,
                      color: maroon,
                      size: 21,
                    ),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        controller.isHidden.value
                            ? Icons
                                .visibility_off_outlined
                            : Icons
                                .visibility_outlined,
                        color: textGrey,
                        size: 21,
                      ),

                      // BACKEND METHOD UNCHANGED
                      onPressed:
                          controller.changestateHidden,
                    ),

                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border:
                        authOutlineInputBorder,

                    enabledBorder:
                        authOutlineInputBorder,

                    focusedBorder:
                        authOutlineInputBorder.copyWith(
                      borderSide:
                          const BorderSide(
                        color: maroon,
                        width: 1.6,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 26),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () async {
                              // BACKEND METHOD UNCHANGED
                              await controller.loginsubmit();
                            },

                  style:
                      ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: maroon,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        maroon.withOpacity(0.65),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),

                  child:
                      controller.isLoading.value
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child:
                                  CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.3,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons
                                      .arrow_forward_rounded,
                                  size: 19,
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
}

/// ===============================================================
/// FORGOT PASSWORD
/// ===============================================================

class AccountText extends StatelessWidget {
  const AccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => Usersignup(),
        );
      },
      child: const Text(
        "Forgot Password?",
        style: TextStyle(
          color: maroon,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// ===============================================================
/// SIGN UP
/// ===============================================================

class NoAccountText extends StatelessWidget {
  const NoAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: lightMaroon,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: maroon.withOpacity(0.10),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(
              color: textGrey,
              fontSize: 13,
            ),
          ),

          GestureDetector(
            onTap: () {
              // IMPORTANT:
              // Explicitly uses UserSignUp.dart
              Get.to(
                () => signup.Usersignup(),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: maroon,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}