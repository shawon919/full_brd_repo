import 'dart:io';

import 'package:brd/Car-Owner/API-Handlers/API-Handlers.dart';
import 'package:brd/Car-Owner/templets/EmailSendOtp.dart';
import 'package:brd/Car-Owner/templets/GetLoginUserInfo.dart';
import 'package:brd/Car-Owner/templets/UserDashboard.dart';
import 'package:brd/Car-Owner/templets/UserMobileOTPVarification.dart';
import 'package:brd/Car-Owner/templets/UserSignIn.dart';
import 'package:brd/Car-Owner/templets/UserSignUp.dart';
import 'package:brd/admin-portion/Admin-templates/Admin_dashboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brd/Driver/DriverDashboard.dart';



class Usergetxcontroller extends GetxController {
  // ============================================================
  // STORAGE
  // ============================================================

  final GetStorage box = GetStorage();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // ============================================================
  // DARK MODE
  // ============================================================

  static const String darkModeKey = 'is_dark_mode';

  /// Global dark mode state.
  ///
  /// This value is used by the entire application.
  final RxBool IsDarkMode = false.obs;

  // ============================================================
  // INITIALIZATION
  // ============================================================

  @override
  void onInit() {
    super.onInit();

    // Load saved theme immediately.
    loadDarkMode();

    // ------------------------------------------------------------
    // Storage listeners
    // ------------------------------------------------------------

    ever(isUserInfo, (value) {
      box.write('Isuserinfo', value);
    });

    ever(token, (value) {
      box.write('token', value);
      box.write('access_token', value);
    });

    userinfoController.addListener(() {
      box.write('username', userinfoController.text);
    });

    ever(useremail, (value) {
      box.write('useremail', value);
    });

    ever(userid, (value) {
      box.write('id', value);
    });

    ever(fullName, (value) {
      box.write('fullName', value);
    });

    ever(email, (value) {
      box.write('email', value);
    });

    ever(phoneNumber, (value) {
      box.write('phoneNumber', value);
    });

    ever(bio, (value) {
      box.write('bio', value);
    });

    ever(profilePicture, (value) {
      box.write('profilePicture', value);
    });

    // User order
    ever(location, (value) {
      box.write('location', value);
    });

    ever(salary, (value) {
      box.write('salary', value);
    });

    ever(experience, (value) {
      box.write('experience', value);
    });

    ever(working_hours, (value) {
      box.write('working_hours', value);
    });

    ever(contact_number, (value) {
      box.write('contact_number', value);
    });

    ever(created_at, (value) {
      box.write('created_at', value);
    });

    ever(currentIndex, (value) {
      box.write('currentIndex', value);
    });

    ever(profileId, (value) {
      box.write('profile_id', value);
    });

    ever(is_admin, (value) {
      box.write('is_admin', value);
    });

    ever(is_staff, (value) {
      box.write('is_staff', value);
    });
  }

  // ============================================================
  // DARK MODE SYSTEM
  // ============================================================

  /// Load theme from persistent storage.
  void loadDarkMode() {
    final dynamic savedMode = box.read(darkModeKey);

    if (savedMode is bool) {
      IsDarkMode.value = savedMode;
    } else {
      IsDarkMode.value = false;
    }

    debugPrint('Dark mode loaded: ${IsDarkMode.value}');
  }

  /// Change theme and save it permanently.
  ///
  /// This value remains after:
  /// - page changes
  /// - logout
  /// - application restart
  /// - device restart
  Future<void> toggleDarkMode(bool value) async {
    IsDarkMode.value = value;

    await box.write(darkModeKey, value);

    debugPrint('Dark mode changed to: $value');
  }

  /// Convenient method for a switch.
  Future<void> toggleDarkModeValue() async {
    await toggleDarkMode(!IsDarkMode.value);
  }

  // ============================================================
  // PASSWORD VISIBILITY
  // ============================================================

  RxBool isHidden = true.obs;

  void changestateHidden() {
    isHidden.value = !isHidden.value;
  }

  // ============================================================
  // LOADING
  // ============================================================

  RxBool isLoading = false.obs;

  // ============================================================
  // USER INFORMATION
  // ============================================================

  RxBool isUserInfo = false.obs;

  RxString token = ''.obs;

  RxString error = ''.obs;

  RxString useremail = ''.obs;

  final TextEditingController userinfoController = TextEditingController();

  void changeInfoPromt(String value) {
    if (value.isEmpty) {
      error.value = "Please fill up the field";
    } else {
      error.value = "";
    }
  }

  Future<void> submitform(String userinfo) async {
    if (userinfo.trim().isEmpty) {
      error.value = "Please enter phone or email";
      return;
    }

    try {
      isLoading.value = true;

      final Map<String, dynamic> user = await Apihandlers.getUserInfo(
        userinfo.trim(),
      );

      debugPrint("user is $user");

      Get.to(UserSignin(), arguments: user);
    } catch (e) {
      error.value = "user does not exist";

      Get.snackbar(
        "Error",
        error.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // OTP
  // ============================================================

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void onchangeOtp(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // ============================================================
  // LOGIN
  // ============================================================

  final TextEditingController passwordController = TextEditingController();

  RxBool is_staff = false.obs;
  RxBool is_admin = false.obs;
  RxBool is_driver = false.obs;

  Future<void> loginsubmit() async {
    final String email = userinfoController.text.trim();

    final String password = passwordController.text.trim();

    try {
      if (password.isEmpty) {
        error.value = "password field is required";
        return;
      }

      isLoading.value = true;

      final user = await Apihandlers.loginUserAPI(email, password);

      final String accessToken = user['access_token'] ?? "";

      final bool isStaff = user['is_staff'] ?? false;

      final bool isAdmin = user['is_admin'] ?? false;

      final bool isDriver = user['is_driver'] ?? false;

      is_staff.value = isStaff;
      is_admin.value = isAdmin;
      is_driver.value = isDriver;

      if (accessToken.isEmpty) {
        throw Exception("Invalid token");
      }

      token.value = accessToken;

      await box.write('access_token', accessToken);

      await box.write('is_staff', isStaff);

      await box.write('is_admin', isAdmin);

      await box.write('is_driver', isDriver);

      fetchUserProfile(accessToken);

      passwordController.clear();

      debugPrint("Token after login: $accessToken");

      if (isAdmin || isStaff) {
        Get.offAll(() => AdminDashboard());
      } else if (isDriver) {
        Get.offAll(() => DriverDashboard());
      } else {
        Get.offAll(() => Userdashboard());
      }
    } catch (e) {
      error.value = e.toString();

      Get.snackbar(
        "Failed",
        error.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // LOAD TOKEN
  // ============================================================

  Future<void> loadtoken() async {
    final String? accessToken = await storage.read(key: "access_token");

    token.value = accessToken ?? "";

    await box.write("token", accessToken ?? "");

    debugPrint('access token is ${token.value}');
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      token.value = "";

      await box.remove("access_token");

      await box.remove("token");

      // IMPORTANT:
      // DO NOT RESET DARK MODE HERE.
      //
      // The user's theme preference must survive logout.

      await Future.delayed(const Duration(milliseconds: 500));

      if (Get.isDialogOpen == true) {
        Get.back();
      }

      Get.offAllNamed('/loginUserinfo');
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      Get.snackbar("Error", e.toString());
    }
  }

  // ============================================================
  // REGISTRATION
  // ============================================================

  RxInt id = 0.obs;

  final TextEditingController fullnameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController userpasswordController = TextEditingController();

  final TextEditingController confirmpasswordController =
      TextEditingController();

  RxString status = ''.obs;

  RxString fullnameError = ''.obs;
  RxString emailError = ''.obs;
  RxString phoneError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  void fullnameValidation(String value) {
    if (value.isEmpty) {
      fullnameError.value = "fullname field is required";
    } else {
      fullnameError.value = '';
    }
  }

  void emailValidation(String value) {
    if (value.isEmpty) {
      emailError.value = "Email field is required";
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = "Enter a valid email";
    } else {
      emailError.value = "";
    }
  }

  void phoneValidation(String value) {
    if (value.isEmpty) {
      phoneError.value = "Phone field is required";
    } else if (value.length < 11) {
      phoneError.value = "Enter a valid Phone number";
    } else {
      phoneError.value = "";
    }
  }

  void passwordValidation(String value) {
    if (value.isEmpty) {
      passwordError.value = "Password is required";
    } else if (value.length < 8) {
      passwordError.value = "Password is short";
    } else {
      passwordError.value = "";
    }
  }

  void confirmPasswordValidation(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = "Confirm password is required";
    } else if (userpasswordController.text != confirmpasswordController.text) {
      confirmPasswordError.value = "Passwords do not match";
    } else {
      confirmPasswordError.value = "";
    }
  }

  bool isFormValid() {
    fullnameValidation(fullnameController.text);

    emailValidation(emailController.text);

    phoneValidation(phoneController.text);

    passwordValidation(userpasswordController.text);

    confirmPasswordValidation(confirmpasswordController.text);

    return fullnameError.value.isEmpty &&
        emailError.value.isEmpty &&
        phoneError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty;
  }

  void userRegistration() async {
    final String fullName = fullnameController.text.trim();

    final String email = emailController.text.trim();

    final String phoneNumber = phoneController.text.trim();

    final String password = userpasswordController.text.trim();

    try {
      if (!isFormValid()) {
        Get.snackbar(
          "Not OK",
          "Please fill all fields correctly",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      final user = await Apihandlers.userregistration(
        fullName,
        email,
        phoneNumber,
        password,
      );

      debugPrint("$user");

      useremail.value = email;

      fullnameController.clear();
      emailController.clear();
      phoneController.clear();
      userpasswordController.clear();
      confirmpasswordController.clear();

      Get.to(
        Usermobileotpvarification(),
        arguments: {'phone_no': phoneNumber, 'email': email},
      );
    } catch (e) {
      error.value = e.toString();

      Get.snackbar(
        "Failed",
        "User already exists",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // MOBILE OTP
  // ============================================================

  void mobileVarification(String phone) async {
    final String otp = otpControllers.map((c) => c.text).join();

    try {
      isLoading.value = true;

      await Apihandlers.MobileVarificationApi(phone, otp);

      Get.to(() => Emailsendotp(), arguments: {'email': useremail.value});

      for (final controller in otpControllers) {
        controller.clear();
      }

      await Apihandlers.sendEmailOtp(useremail.value);
    } catch (e) {
      Get.snackbar(
        "Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  RxString mobile = ''.obs;

  RxBool isOtpLoading = false.obs;

  void resendmobileotp() async {
    try {
      isOtpLoading.value = true;

      await Apihandlers.resendMobileVarification(mobile.value);
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Failed to resend OTP",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isOtpLoading.value = false;
    }
  }

  // ============================================================
  // EMAIL OTP
  // ============================================================

  final List<TextEditingController> EmailotpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> EmailfocusNodes = List.generate(6, (_) => FocusNode());

  void onEmailchangeOtp(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      EmailfocusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      EmailfocusNodes[index - 1].requestFocus();
    }
  }

  void EmailVarification(String email) async {
    final String otp = EmailotpControllers.map((c) => c.text).join();

    try {
      isLoading.value = true;

      final result = await Apihandlers.emailVarification(email, otp);

      if (result['message'] == "Email verified successfully") {
        final String accessToken = result['access_token'] ?? "";

        token.value = accessToken;

        await box.write('access_token', accessToken);

        fetchUserProfile(token.value);

        Get.off(Userdashboard());
      } else {
        Get.snackbar(
          "Failed",
          "Invalid OTP",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // USER PROFILE
  // ============================================================

  RxString profilePicture = ''.obs;
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString bio = ''.obs;

  RxInt userid = 0.obs;
  RxInt profileId = 0.obs;

  void fetchUserProfile(String token) async {
    const String mediaURL =
        'https://nonideologically-minuscular-hoyt.ngrok-free.dev';

    try {
      isLoading.value = true;

      if (token.isEmpty) {
        return;
      }

      final profile = await Apihandlers.fetchuserporfile(token);

      debugPrint('Fetched profile: $profile');

      if (profile.isEmpty) {
        profilePicture.value =
            "https://cdn-icons-png.flaticon.com/512/149/149071.png";

        return;
      }

      final rawId = profile['profile_id'];

      if (rawId is int) {
        profileId.value = rawId;
      } else {
        profileId.value = int.tryParse(rawId.toString()) ?? 0;
      }

      userid.value = profile['userid'] ?? 0;

      fullName.value = profile['fullName'] ?? '';

      email.value = profile['email'] ?? '';

      phoneNumber.value = profile['phone'] ?? '';

      bio.value = profile['bio'] ?? '';

      final String image = profile['profilePicture'] ?? '';

      if (image.isNotEmpty) {
        profilePicture.value = image.startsWith('http')
            ? image
            : mediaURL + image;
      } else {
        profilePicture.value =
            "https://cdn-icons-png.flaticon.com/512/149/149071.png";
      }

      await box.write('profile_id', profileId.value);

      await box.write('id', userid.value);

      await box.write('fullName', fullName.value);

      await box.write('email', email.value);

      await box.write('phone', phoneNumber.value);

      await box.write('bio', bio.value);

      await box.write('profilePicture', profilePicture.value);

      debugPrint('User: ${fullName.value} loaded successfully.');
    } catch (e) {
      debugPrint("Controller Error: $e");

      Get.snackbar(
        "Error",
        "An unexpected error occurred while loading profile",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // USER ORDERS
  // ============================================================

  RxString location = ''.obs;
  RxString salary = ''.obs;
  RxString experience = ''.obs;
  RxString working_hours = ''.obs;
  RxString contact_number = ''.obs;
  RxString created_at = ''.obs;

  RxInt orderrid = 0.obs;

  void fetchUserOrder(String token) async {
    try {
      isLoading.value = true;

      final user = await Apihandlers.userApplication(token);

      orderrid.value = user['id'] ?? 0;

      location.value = user['location'] ?? '';

      salary.value = user['salary']?.toString() ?? '';

      experience.value = user['experience'] ?? '';

      working_hours.value = user['working_hours'] ?? '';

      contact_number.value = user['contact_number'] ?? '';

      created_at.value = user['created_at'] ?? '';

      await box.write('location', location.value);

      await box.write('salary', salary.value);

      await box.write('experience', experience.value);

      await box.write('working_hours', working_hours.value);

      await box.write('contact_number', contact_number.value);

      await box.write('created_at', created_at.value);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user orders");
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // PROFILE UPLOAD
  // ============================================================

  RxBool profileloading = false.obs;

  TextEditingController bioController = TextEditingController();

  Rx<File?> profileImage = Rx<File?>(null);

  Future<void> subfunction(String text) async {
    final picker = ImagePicker();

    XFile? pickedFile;

    if (text == 'chose from gallery') {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
    } else if (text == 'take a photo') {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
    }

    if (pickedFile == null) {
      return;
    }

    final file = File(pickedFile.path);

    final length = await file.length();

    if (length > 2000000) {
      Get.snackbar("Error", "File too large");
    }

    profileImage.value = file;
  }

  void uploadUserProfile(String bio) async {
    try {
      profileloading.value = true;

      final String accessToken = box.read('access_token') ?? '';

      if (profileImage.value == null) {
        Get.snackbar(
          'Error',
          'Please select an image first',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }

      final bool success = await Apihandlers().uploadProfile(
        accessToken,
        bio,
        profileImage.value!,
      );

      if (success) {
        final bool isAdmin = box.read('is_admin') ?? false;

        final bool isStaff = box.read('is_staff') ?? false;

        fetchUserProfile(accessToken);

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.off(
          () => (isStaff || isAdmin) ? AdminDashboard() : Userdashboard(),
        );

        profileImage.value = null;

        bioController.clear();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      profileloading.value = false;
    }
  }

  // ============================================================
  // USER APPLICATION
  // ============================================================

  TextEditingController locationcontroller = TextEditingController();

  TextEditingController salarycontroller = TextEditingController();

  TextEditingController experiencecontroller = TextEditingController();

  TextEditingController workingcontroller = TextEditingController();

  void UploadUserApplication() async {
    final String accessToken = box.read('access_token') ?? '';

    try {
      isLoading.value = true;

      final result = await Apihandlers().uploadUserApplication(
        location: locationcontroller.text.trim(),
        salary: salarycontroller.text.trim(),
        experience: experiencecontroller.text.trim(),
        workingHour: workingcontroller.text.trim(),
        token: accessToken,
      );

      debugPrint("$result");

      Get.snackbar(
        "Success",
        "Uploaded successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.to(() => Userdashboard());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // UPDATE USER PROFILE
  // ============================================================

  TextEditingController user_bio = TextEditingController();

  void updateUserProfile() async {
    final String accessToken = box.read('access_token') ?? '';

    try {
      profileloading.value = true;

      if (profileImage.value == null) {
        Get.snackbar(
          "Error",
          "Please select a profile image",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }

      final result = await Apihandlers().updateuserProfile(
        profileImage.value!,
        user_bio.text,
        accessToken,
      );

      debugPrint("$result");

      Get.snackbar(
        "Success",
        "Profile updated successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      final bool isAdmin = box.read('is_admin') ?? false;

      final bool isStaff = box.read('is_staff') ?? false;

      Get.offAll(
        () => (isStaff || isAdmin) ? AdminDashboard() : Userdashboard(),
      );
    } catch (e) {
      debugPrint("$e");

      Get.snackbar(
        'Error',
        'Failed to update profile',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      profileloading.value = false;
    }
  }

  // ============================================================
  // FORGET PASSWORD
  // ============================================================

  TextEditingController valuecontroller = TextEditingController();

  RxString errorvalue = ''.obs;

  void UserForgetPassword(String value) async {
    try {
      isLoading.value = true;

      final data = await Apihandlers().userForgetpassword(value);

      if (data['message'] == "otp send to email successfully") {
        Get.snackbar(
          "Success",
          "OTP sent to email successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        errorvalue.value = '';
      } else {
        errorvalue.value = data['message'];
      }
    } catch (e) {
      debugPrint("$e");
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // CURRENT INDEX
  // ============================================================

  RxInt currentIndex = 0.obs;

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    userinfoController.dispose();
    passwordController.dispose();

    fullnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    userpasswordController.dispose();
    confirmpasswordController.dispose();

    bioController.dispose();

    locationcontroller.dispose();
    salarycontroller.dispose();
    experiencecontroller.dispose();
    workingcontroller.dispose();

    user_bio.dispose();
    valuecontroller.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    for (final controller in EmailotpControllers) {
      controller.dispose();
    }

    for (final node in EmailfocusNodes) {
      node.dispose();
    }

    super.onClose();
  }




  Future<void> checkLoginStatus() async {
  final String accessToken = box.read('access_token') ?? '';

  final bool isAdmin = box.read('is_admin') ?? false;
  final bool isStaff = box.read('is_staff') ?? false;
  final bool isDriver = box.read('is_driver') ?? false;

  debugPrint("Startup access token: $accessToken");
  debugPrint("Startup is_admin: $isAdmin");
  debugPrint("Startup is_staff: $isStaff");
  debugPrint("Startup is_driver: $isDriver");

  if (accessToken.isEmpty) {
    Get.offAllNamed('/loginUserinfo');
    return;
  }

  // Restore login state
  token.value = accessToken;
  is_admin.value = isAdmin;
  is_staff.value = isStaff;
  is_driver.value = isDriver;

  // Restore cached profile data immediately
  userid.value = box.read('id') ?? 0;
  profileId.value = box.read('profile_id') ?? 0;
  fullName.value = box.read('fullName') ?? '';
  email.value = box.read('email') ?? '';
  phoneNumber.value = box.read('phone') ?? '';
  bio.value = box.read('bio') ?? '';
  profilePicture.value = box.read('profilePicture') ?? '';

  // Go directly to the correct dashboard
  if (isAdmin || isStaff) {
    Get.offAll(() => AdminDashboard());
  } else if (isDriver) {
    Get.offAll(() =>  DriverDashboard());
  } else {
    Get.offAll(() => Userdashboard());
  }
}
}
