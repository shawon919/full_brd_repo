import 'dart:io';
import 'package:brd/Car-Owner/API-Handlers/API-Handlers.dart';
import 'package:brd/Driver/DriverPhoneVarification.dart';
import 'package:brd/Driver/DriverEmailVarification.dart';
import 'package:brd/Driver/DriverFinalVarificationPart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DriverApihandlers.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";


class Drivergetxcontroller extends GetxController {
  // ---------------- TEXT CONTROLLERS ----------------
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // ---------------- FILES ----------------
  Rx<File?> dlFrontFile = Rx<File?>(null);
  Rx<File?> dlBackFile = Rx<File?>(null);
  Rx<File?> nidFrontFile = Rx<File?>(null);
  Rx<File?> nidBackFile = Rx<File?>(null);
  Rx<File?> cvFile = Rx<File?>(null);

  // ---------------- LOADING STATES ----------------
  RxBool isLoadingRegister = false.obs;
  RxBool isLoadingPhoneOtp = false.obs;
  RxBool isLoadingEmailOtp = false.obs;
  RxBool isLoadingResendEmail = false.obs;

  // =====================================================
  // 🚀 MAIN REGISTRATION FLOW (SINGLE FUNCTION)
  // =====================================================
  Future<void> driverFullRegistrationFlow() async {
    try {
      isLoadingRegister.value = true;

      // 🔥 VALIDATION (IMPORTANT)
      if (dlFrontFile.value == null ||
          dlBackFile.value == null ||
          nidFrontFile.value == null ||
          nidBackFile.value == null ||
          cvFile.value == null) {
        Get.snackbar("Error", "Please upload all required documents");
        return;
      }

      // 1️⃣ REGISTER DRIVER
      await DriverApihandler().driverRegister(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        description: descriptionController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        password: passwordController.text.trim(),
        dlFront: dlFrontFile.value!,
        dlBack: dlBackFile.value!,
        nidFront: nidFrontFile.value!,
        nidBack: nidBackFile.value!,
        cvFile: cvFile.value!,
      );

      // 2️⃣ GO TO OTP SCREEN (recommended flow)
      Get.to(
        Driverphonevarification(),
        arguments: {
          "phone": phoneController.text.trim(),
          "email": emailController.text.trim(),
        },
      );
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
    } finally {
      isLoadingRegister.value = false;
    }
  }

  // =====================================================
  // 📱 PHONE OTP VERIFY
  // =====================================================

  void onchangePhoneOtp(String value, int index) {
    if (value.isNotEmpty) {
      if (index < phoneOtpFocusNodes.length - 1) {
        FocusScope.of(Get.context!).requestFocus(phoneOtpFocusNodes[index + 1]);
      }
    } else {
      if (index > 0) {
        FocusScope.of(Get.context!).requestFocus(phoneOtpFocusNodes[index - 1]);
      }
    }
  }

  // ---------------- PHONE OTP ----------------
  List<TextEditingController> phoneOtpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  List<FocusNode> phoneOtpFocusNodes = List.generate(6, (index) => FocusNode());

  Future<void> verifyPhone() async {
    try {
      isLoadingPhoneOtp.value = true;

      await DriverApihandler().verifyDriverPhone(
        phone: phoneController.text.trim(),
        otp: phoneOtpControllers.map((e) => e.text.trim()).join(),
      );

      Get.to(
        Driveremailvarification(),
        arguments: {"email": emailController.text.trim()},
      );
      resendEmailOtp();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingPhoneOtp.value = false;
    }
  }

  // =====================================================
  // 📧 EMAIL OTP VERIFY
  // =====================================================

  // ---------------- EMAIL OTP ----------------
  List<TextEditingController> emailOtpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  List<FocusNode> emailOtpFocusNodes = List.generate(6, (index) => FocusNode());

  void onchangeEmailOtp(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field
      if (index < emailOtpFocusNodes.length - 1) {
        FocusScope.of(Get.context!).requestFocus(emailOtpFocusNodes[index + 1]);
      }
    } else {
      // Move to previous field
      if (index > 0) {
        FocusScope.of(Get.context!).requestFocus(emailOtpFocusNodes[index - 1]);
      }
    }
  }

  Future<void> verifyEmail() async {
    try {
      isLoadingEmailOtp.value = true;

      await DriverApihandler().driverEmailVerification(
        email: emailController.text.trim(),
        otp: emailOtpControllers.map((e) => e.text.trim()).join(),
      );

      Get.offAll(
        DriverFinalVerificationPart(),
        arguments: {"email": emailController.text.trim()},
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingEmailOtp.value = false;
    }
  }

  // =====================================================
  // 🔁 RESEND EMAIL OTP
  // =====================================================
  Future<void> resendEmailOtp() async {
    try {
      isLoadingResendEmail.value = true;

      await DriverApihandler().DriverEmailOtpsend(
        email: emailController.text.trim(),
      );

      Get.snackbar("Success", "OTP sent to email");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingResendEmail.value = false;
    }
  }

  // =====================================================
  // 🧹 CLEAR FORM
  // =====================================================
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    descriptionController.clear();
    phoneController.clear();
    passwordController.clear();

    dlFrontFile.value = null;
    dlBackFile.value = null;
    nidFrontFile.value = null;
    nidBackFile.value = null;
    cvFile.value = null;
  }

  // =====================================================
  // DISPOSE
  // =====================================================
  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }



  final FlutterSecureStorage secureStorage =
      const FlutterSecureStorage();

  final RxMap<String, dynamic> driverProfile =
      <String, dynamic>{}.obs;

  final RxInt driverId = 0.obs;

  final RxString fullName = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxString profilePicture = ''.obs;
  final RxString bio = ''.obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loadDriverProfile();
  }

  Future<String> _getAccessToken() async {
    final String token =
        await secureStorage.read(key: 'access_token') ?? '';

    return token;
  }

  Future<void> loadDriverProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final String accessToken = await _getAccessToken();

      if (accessToken.isEmpty) {
        errorMessage.value = 'Access token not found.';
        return;
      }

      final Map<String, dynamic> data =
          await DriverApihandler.fetchDriverProfile(accessToken);

      driverProfile.assignAll(data);

      driverId.value = _getInt(data['id']);

      fullName.value =
          data['fullName']?.toString() ??
          data['full_name']?.toString() ??
          '';

      email.value =
          data['email']?.toString() ?? '';

      phone.value =
          data['phone']?.toString() ?? '';

      bio.value =
          data['bio']?.toString() ?? '';

      final dynamic pictureValue =
          data['profile_picture'] ??
          data['profilePicture'] ??
          data['profile_image'] ??
          '';

      final String picture =
          pictureValue?.toString() ?? '';

      if (picture.isEmpty) {
        profilePicture.value = '';
      } else if (picture.startsWith('http://') ||
          picture.startsWith('https://')) {
        profilePicture.value = picture;
      } else {
        profilePicture.value =
            '${"https://nonideologically-minuscular-hoyt.ngrok-free.dev"}/$picture';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDriverProfile() async {
    await loadDriverProfile();
  }

  int _getInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(
          value?.toString() ?? '0',
        ) ??
        0;
  }






  
}
