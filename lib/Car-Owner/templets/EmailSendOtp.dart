import 'package:brd/Car-Owner/API-Handlers/API-Handlers.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class Emailsendotp extends StatelessWidget {
  Emailsendotp({super.key});

  final Usergetxcontroller signingetxcontroller =
      Get.put(Usergetxcontroller());

  static const Color maroon = Color(0xFF800000);
  static const Color darkMaroon = Color(0xFF5C0000);
  static const Color lightMaroon = Color(0xFFFFF5F5);
  static const Color background = Color(0xFFF7F7F9);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color borderGrey = Color(0xFFE2E4E8);

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments ?? {};
    final String email = data['email'] ?? '';

    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // ==================================================
                  // HEADER
                  // ==================================================

                  Container(
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
                        bottomLeft: Radius.circular(34),
                        bottomRight: Radius.circular(34),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Decorative circle
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

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            // Back button
                            Material(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius:
                                  BorderRadius.circular(14),
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(14),
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

                            const SizedBox(height: 28),

                            // Badge
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Colors.white.withOpacity(0.13),
                                borderRadius:
                                    BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white
                                      .withOpacity(0.15),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    'EMAIL VERIFICATION',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.w700,
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            const Text(
                              'Verify your email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 29,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Enter the verification code sent to your email.',
                              style: TextStyle(
                                color:
                                    Colors.white.withOpacity(0.82),
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // CONTENT
                  // ==================================================

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      24,
                      16,
                      30,
                    ),
                    child: Column(
                      children: [
                        // Information card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20),
                            border: Border.all(
                              color: borderGrey,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(0.035),
                                blurRadius: 20,
                                offset:
                                    const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Email icon
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: lightMaroon,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.mark_email_read_outlined,
                                  color: maroon,
                                  size: 31,
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text(
                                'Email OTP Verification',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'We sent a verification code to',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 7),

                              // Email
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: lightMaroon,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        maroon.withOpacity(0.10),
                                  ),
                                ),
                                child: Text(
                                  email,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: maroon,
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 9),

                              const Text(
                                'Enter the 6-digit code below to continue.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 22),

                              // OTP FORM
                              OtpForm(),

                              const SizedBox(height: 18),

                              // Resend
                              TextButton(
                                onPressed: () async {
                                  // EXISTING API CALL - UNCHANGED
                                  await Apihandlers.sendEmailOtp(email);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: maroon,
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.refresh_rounded,
                                      size: 17,
                                    ),
                                    SizedBox(width: 7),
                                    Text(
                                      "Resend OTP Code",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Security card
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(15),
                            border: Border.all(
                              color: borderGrey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.grey.shade500,
                                size: 15,
                              ),
                              const SizedBox(width: 7),
                              Flexible(
                                child: Text(
                                  'Your verification is secure and protected.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Colors.grey.shade500,
                                    fontSize: 10.5,
                                  ),
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
          ),

          // ==================================================
          // FULL SCREEN LOADER
          // EXISTING LOGIC - UNCHANGED
          // ==================================================

          Obx(() {
            return signingetxcontroller.isOtpLoading.value
                ? Container(
                    color: Colors.black.withOpacity(0.35),
                    child: const Center(
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              color: maroon,
                              strokeWidth: 2.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}

// ============================================================
// OTP BORDER
// ============================================================

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xFFE0E1E5),
    width: 1.2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(14),
  ),
);

// ============================================================
// OTP FORM
// ============================================================

class OtpForm extends StatelessWidget {
  OtpForm({super.key});

  final Usergetxcontroller signingetxcontroller =
      Get.find();

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments ?? {};
    final String email = data['email'] ?? '';

    return Form(
      child: Column(
        children: [
          // ========================================================
          // OTP LABEL
          // ========================================================

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Verification Code',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ========================================================
          // OTP BOXES
          // ========================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) {
                return SizedBox(
                  height: 54,
                  width: 45,
                  child: TextFormField(
                    controller:
                        signingetxcontroller
                            .EmailotpControllers[index],

                    focusNode:
                        signingetxcontroller
                            .EmailfocusNodes[index],

                    textAlign: TextAlign.center,

                    keyboardType:
                        TextInputType.number,

                    textInputAction:
                        TextInputAction.next,

                    // EXISTING OTP LOGIC - UNCHANGED
                    onChanged: (value) =>
                        signingetxcontroller
                            .onEmailchangeOtp(
                          value,
                          index,
                        ),

                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly,
                    ],

                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),

                    cursorColor:
                        const Color(0xFF800000),

                    decoration:
                        InputDecoration(
                      hintText: "0",

                      hintStyle:
                          const TextStyle(
                        color: Color(0xFFD0D1D5),
                        fontSize: 18,
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      contentPadding:
                          EdgeInsets.zero,

                      border:
                          authOutlineInputBorder,

                      enabledBorder:
                          authOutlineInputBorder,

                      focusedBorder:
                          authOutlineInputBorder
                              .copyWith(
                        borderSide:
                            const BorderSide(
                          color: Color(0xFF800000),
                          width: 1.8,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          // ========================================================
          // CONTINUE BUTTON
          // ========================================================

          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                // EXISTING LOGIC - UNCHANGED
                onPressed:
                    signingetxcontroller
                            .isLoading.value
                        ? null
                        : () {
                            signingetxcontroller
                                .EmailVarification(email);
                          },

                style:
                    ElevatedButton.styleFrom(
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

                child:
                    signingetxcontroller
                            .isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2.3,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                "Verify & Continue",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 9),
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
    );
  }
}