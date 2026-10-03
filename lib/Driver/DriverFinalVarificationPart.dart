import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverFinalVerificationPart extends StatelessWidget {
  DriverFinalVerificationPart({super.key});

  final String email = Get.arguments?['email'] ?? '';

  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5C0000);
  static const Color background = Color(0xFFF8F8FA);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color borderGrey = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ============================================================
      // APP BAR
      // ============================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: maroon,
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: const Text(
          "Application Submitted",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            20,
            35,
            20,
            30,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ======================================================
              // SUCCESS / VERIFICATION ICON
              // ======================================================

              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: maroon.withOpacity(0.08),
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: maroon,
                  ),
                  child: const Icon(
                    Icons.verified_user_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ======================================================
              // TITLE
              // ======================================================

              const Text(
                "Application Under Review",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textDark,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 12),

              // ======================================================
              // SUBTITLE
              // ======================================================

              const Text(
                "Thank you for completing your verification.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textGrey,
                  fontSize: 14.5,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // ======================================================
              // MAIN INFORMATION CARD
              // ======================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: borderGrey,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // ==================================================
                    // STATUS
                    // ==================================================

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: maroon.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            color: maroon,
                            size: 17,
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Verification in progress",
                            style: TextStyle(
                              color: maroon,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ==================================================
                    // MESSAGE
                    // ==================================================

                    const Text(
                      "Your account is being reviewed by our "
                      "administration team.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Once your verification is complete, "
                      "we will notify you at:",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 13.5,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==================================================
                    // EMAIL CARD
                    // ==================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: maroon.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.email_outlined,
                              color: maroon,
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
                                  "Notification email",
                                  style: TextStyle(
                                    color: textGrey,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  email.isNotEmpty
                                      ? email
                                      : "Email address",
                                  maxLines: 2,
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
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ======================================================
              // WHAT HAPPENS NEXT CARD
              // ======================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What happens next?",
                      style: TextStyle(
                        color: textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _StepItem(
                      number: "1",
                      title: "Application review",
                      description:
                          "Our administration team will review your information.",
                    ),

                    _StepItem(
                      number: "2",
                      title: "Account verification",
                      description:
                          "Your submitted documents and information will be verified.",
                    ),

                    _StepItem(
                      number: "3",
                      title: "Notification",
                      description:
                          "You will receive an email once the verification is complete.",
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ======================================================
              // SECURITY MESSAGE
              // ======================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: maroon.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: maroon,
                      size: 19,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Please keep an eye on your email for "
                        "updates regarding your application.",
                        style: TextStyle(
                          color: textGrey,
                          fontSize: 12.5,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ======================================================
              // BOTTOM BRANDING
              // ======================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 7,
                    width: 7,
                    decoration: const BoxDecoration(
                      color: maroon,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 7),

                  const Text(
                    "BRD Driver Services",
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// STEP ITEM
// ==================================================================

class _StepItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final bool isLast;

  const _StepItem({
    required this.number,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  static const Color maroon = Color(0xFF800000);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color borderGrey = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // NUMBER / LINE
          // ==========================================================

          SizedBox(
            width: 34,
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: maroon,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: maroon.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      color: borderGrey,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // ==========================================================
          // CONTENT
          // ==========================================================

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: const TextStyle(
                      color: textGrey,
                      fontSize: 12.5,
                      height: 1.45,
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