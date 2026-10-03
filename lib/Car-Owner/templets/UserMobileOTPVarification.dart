import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';

// ================================================================
// UI COLORS
// ================================================================

const Color otpMaroon = Color(0xFF800000);
const Color otpDarkMaroon = Color(0xFF5C0000);
const Color otpLightMaroon = Color(0xFFF9EEEE);

const Color otpBackground = Color(0xFFF7F7F9);
const Color otpTextDark = Color(0xFF1A1A1A);
const Color otpTextGrey = Color(0xFF6B7280);
const Color otpBorderColor = Color(0xFFE2E4E8);

// ================================================================
// OTP INPUT BORDER
// ================================================================

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xFFD9D9DF),
    width: 1.2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(14),
  ),
);

// ================================================================
// USER MOBILE OTP VERIFICATION
// ================================================================

class Usermobileotpvarification extends StatelessWidget {
  Usermobileotpvarification({super.key});

  final Usergetxcontroller signingetxcontroller =
      Get.put(Usergetxcontroller());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    final String phone_no = args['phone_no'] ?? '';
    final String email = args['email'] ?? '';

    // ==========================================================
    // EXISTING LOGIC - UNCHANGED
    // ==========================================================

    // Set email once
    signingetxcontroller.useremail.value = email;

    // Set mobile once
    signingetxcontroller.mobile.value = phone_no;

    return Scaffold(
      backgroundColor: otpBackground,

      // ========================================================
      // APP BAR
      // UI ONLY
      // ========================================================

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: otpMaroon,
        foregroundColor: Colors.white,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
          ),
        ),

        title: const Text(
          "OTP Verification",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Stack(
        children: [
          // ======================================================
          // MAIN UI
          // ======================================================

          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // =================================================
                    // MAROON HEADER
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        22,
                        28,
                        22,
                        34,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            otpMaroon,
                            otpDarkMaroon,
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
                            top: -80,
                            child: Container(
                              width: 210,
                              height: 210,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(
                                  0.06,
                                ),
                              ),
                            ),
                          ),

                          // Decorative circle
                          Positioned(
                            left: -75,
                            bottom: -120,
                            child: Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(
                                  0.04,
                                ),
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              // =================================================
                              // ICON
                              // =================================================

                              Container(
                                height: 68,
                                width: 68,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                    0.14,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white
                                        .withOpacity(0.18),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.verified_user_outlined,
                                  color: Colors.white,
                                  size: 31,
                                ),
                              ),

                              const SizedBox(height: 18),

                              // =================================================
                              // TITLE
                              // =================================================

                              const Text(
                                "Verify Your Phone",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  height: 1.15,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // =================================================
                              // SUBTITLE
                              // =================================================

                              Text(
                                "Enter the verification code sent to your phone number.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(
                                    0.82,
                                  ),
                                  fontSize: 13,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // =================================================
                    // CONTENT
                    // =================================================

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        24,
                        18,
                        30,
                      ),
                      child: Column(
                        children: [
                          // =================================================
                          // PHONE INFORMATION CARD
                          // =================================================

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 17,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(17),
                              border: Border.all(
                                color: otpBorderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: otpLightMaroon,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.phone_android_rounded,
                                    color: otpMaroon,
                                    size: 21,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Verification code sent to",
                                        style: TextStyle(
                                          color: otpTextGrey,
                                          fontSize: 11.5,
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        "+088 $phone_no",
                                        style: const TextStyle(
                                          color: otpTextDark,
                                          fontSize: 14,
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

                          const SizedBox(height: 24),

                          // =================================================
                          // OTP CARD
                          // =================================================

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(
                              18,
                              22,
                              18,
                              22,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(22),
                              border: Border.all(
                                color: otpBorderColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.035,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 7),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Enter OTP",
                                  style: TextStyle(
                                    color: otpTextDark,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                const Text(
                                  "Enter the 6-digit code to continue",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: otpTextGrey,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 22),

                                // =================================================
                                // OTP FORM
                                // =================================================

                                OtpForm(),

                                const SizedBox(height: 18),

                                // =================================================
                                // EXPIRATION INFORMATION
                                // =================================================

                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: otpLightMaroon,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize:
                                        MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: otpMaroon,
                                        size: 16,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        "This code will expire in 00:30",
                                        style: TextStyle(
                                          color: otpMaroon,
                                          fontSize: 11.5,
                                          fontWeight:
                                              FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // =================================================
                                // RESEND OTP
                                // EXISTING LOGIC - UNCHANGED
                                // =================================================

                                TextButton(
                                  onPressed: () {
                                    signingetxcontroller
                                        .resendmobileotp();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: otpMaroon,
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize:
                                        MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.refresh_rounded,
                                        size: 18,
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

                          const SizedBox(height: 20),

                          // =================================================
                          // SECURITY MESSAGE
                          // =================================================

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
                                "Your verification is secure",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ======================================================
          // FULL SCREEN LOADER
          // EXISTING LOGIC - UNCHANGED
          // ======================================================

          Obx(() {
            return signingetxcontroller.isOtpLoading.value
                ? Container(
                    color: Colors.black.withOpacity(0.35),
                    child: Center(
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.12),
                              blurRadius: 25,
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child:
                                  CircularProgressIndicator(
                                color: otpMaroon,
                                strokeWidth: 2.8,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Please wait...",
                              style: TextStyle(
                                color: otpTextDark,
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ],
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

// ================================================================
// OTP FORM
// ================================================================

class OtpForm extends StatelessWidget {
  OtpForm({super.key});

  final Usergetxcontroller signingetxcontroller =
      Get.find();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    final String phone_no = args['phone_no'] ?? '';

    return Form(
      child: Column(
        children: [
          // ==========================================================
          // OTP BOXES
          // EXISTING LOGIC UNCHANGED
          // ==========================================================

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
                    controller: signingetxcontroller
                        .otpControllers[index],

                    focusNode: signingetxcontroller
                        .focusNodes[index],

                    textAlign: TextAlign.center,

                    keyboardType:
                        TextInputType.number,

                    textInputAction:
                        TextInputAction.next,

                    // EXISTING LOGIC - UNCHANGED
                    onChanged: (value) =>
                        signingetxcontroller
                            .onchangeOtp(
                          value,
                          index,
                        ),

                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        1,
                      ),
                      FilteringTextInputFormatter
                          .digitsOnly,
                    ],

                    style: const TextStyle(
                      color: otpMaroon,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),

                    decoration: InputDecoration(
                      counterText: "",

                      hintText: "0",

                      hintStyle: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w600,
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
                          color: otpMaroon,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 26),

          // ==========================================================
          // CONTINUE BUTTON
          // EXISTING LOGIC UNCHANGED
          // ==========================================================

          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed:
                    signingetxcontroller.isLoading.value
                        ? null
                        : () {
                            // EXISTING LOGIC - UNCHANGED
                            signingetxcontroller
                                .mobileVarification(
                              phone_no,
                            );
                          },

                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  backgroundColor: otpMaroon,

                  disabledBackgroundColor:
                      const Color(0xFFB98787),

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),

                child:
                    signingetxcontroller
                            .isLoading.value
                        ? const SizedBox(
                            height: 22,
                            width: 22,
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
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),

                              SizedBox(width: 8),

                              Icon(
                                Icons
                                    .arrow_forward_rounded,
                                color: Colors.white,
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