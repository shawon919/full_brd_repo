import 'package:brd/Driver/Drivergetxcontroller.dart';
import 'package:brd/admin-portion/Admin-templates/Admin_dashboard.dart';
import 'package:brd/admin-portion/AdmingetXcontroller/AdmingetxController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';

class Driveremailvarification extends StatelessWidget {
  Driveremailvarification({super.key});

  final Drivergetxcontroller controller =
      Get.put(Drivergetxcontroller());

  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5C0000);
  static const Color background = Color(0xFFF8F8FA);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color borderGrey = Color(0xFFE5E7EB);

  static void showMaroonSnackbar({
    required String title,
    required String message,
    IconData icon = Icons.info_outline_rounded,
  }) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: maroon,
      colorText: Colors.white,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
      borderRadius: 14,
      duration: const Duration(seconds: 4),
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.20),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
      icon: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 21,
        ),
      ),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white.withOpacity(0.92),
          fontSize: 13,
          height: 1.35,
        ),
      ),
      mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(40, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Icon(
          Icons.close_rounded,
          color: Colors.white,
          size: 21,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    String email = args['email'] ?? '';

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: maroon,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "OTP Verification",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  28,
                  20,
                  30,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 76,
                      width: 76,
                      decoration: BoxDecoration(
                        color: maroon.withOpacity(0.10),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(9),
                        decoration: const BoxDecoration(
                          color: maroon,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.mark_email_read_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Verify Your Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textDark,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Enter the 6-digit verification code\n"
                      "we sent to your email address.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 14.5,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: maroon.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Icon(
                              Icons.email_outlined,
                              color: maroon,
                              size: 20,
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
                                    color: textGrey,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: textDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

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
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: borderGrey,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: OtpForm(),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 13.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 6),
                            minimumSize: Size.zero,
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                              color: maroon,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 14,
                          color: textGrey,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Your verification is secure",
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Obx(() {
            return controller.isLoadingEmailOtp.value
                ? Container(
                    color: Colors.black.withOpacity(0.35),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                  maroon,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Verifying...",
                              style: TextStyle(
                                color: textDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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

class OtpForm extends StatelessWidget {
  OtpForm({super.key});

  final Drivergetxcontroller controller = Get.find();

  static const Color maroon = Color(0xFF800000);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color borderGrey = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String email = args['email'] ?? '';

    return Form(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter verification code",
              style: TextStyle(
                color: textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) {
                return SizedBox(
                  height: 54,
                  width: 45,
                  child: TextFormField(
                    controller:
                        controller.emailOtpControllers[index],
                    focusNode:
                        controller.emailOtpFocusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,

                    onChanged: (value) {
                      controller.onchangeEmailOtp(
                        value,
                        index,
                      );
                    },

                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    style: const TextStyle(
                      color: textDark,
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),

                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "•",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 20,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: borderGrey,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: borderGrey,
                          width: 1.2,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: maroon,
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

          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.isLoadingEmailOtp.value
                    ? null
                    : () {
                        controller.verifyEmail();
                      },

                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: maroon,
                  disabledBackgroundColor:
                      maroon.withOpacity(0.65),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),

                child: controller.isLoadingEmailOtp.value
                    ? const SizedBox(
                        height: 21,
                        width: 21,
                        child: CircularProgressIndicator(
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
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 19,
                            color: Colors.white,
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