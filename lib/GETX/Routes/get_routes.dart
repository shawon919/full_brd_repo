import 'package:brd/Car-Owner/templets/AccountView.dart';
import 'package:brd/Car-Owner/templets/ApplicationPage.dart';
import 'package:brd/Car-Owner/templets/EmailSendOtp.dart';
import 'package:brd/Car-Owner/templets/GetLoginUserInfo.dart';
import 'package:brd/Car-Owner/templets/SetNewPassword.dart';
import 'package:brd/Car-Owner/templets/SubmitOTPForgetpassword.dart';
import 'package:brd/Car-Owner/templets/Submituser_info_form.dart'
    as submituserinfoform;
import 'package:brd/Car-Owner/templets/UserAccountPage.dart';
import 'package:brd/Car-Owner/templets/UserDashboard.dart';
import 'package:brd/Car-Owner/templets/UserForgetpassword.dart';
import 'package:brd/Car-Owner/templets/UserMobileOTPVarification.dart';
import 'package:brd/Car-Owner/templets/UserProfile.dart';
import 'package:brd/Car-Owner/templets/UserSignIn.dart';

// UserSignUp.dart contains Usersignup.
import 'package:brd/Car-Owner/templets/UserSignUp.dart'
    as signup;

// ============================================================
// DRIVER
// ============================================================

import 'package:brd/Driver/DriverDashboard.dart';
import 'package:brd/Driver/DriverEmailVarification.dart';
import 'package:brd/Driver/DriverFinalVarificationPart.dart';
import 'package:brd/Driver/DriverRegistration.dart';

// ============================================================
// ADMIN
// ============================================================

import 'package:brd/admin-portion/Admin-templates/Admin_dashboard.dart';
import 'package:brd/admin-portion/Admin-templates/DriverApplicationView.dart';
import 'package:brd/admin-portion/Admin-templates/Driverlist.dart';
import 'package:brd/admin-portion/Admin-templates/RealDriverList.dart';
import 'package:brd/admin-portion/Admin-templates/UserList.dart';

import 'package:brd/flutter_storage/auth_middleware.dart';
import 'package:brd/hire_service/views/admin_billing_page.dart';
import 'package:brd/hire_service/views/admin_salary_sections.dart';
import 'package:brd/hire_service/views/service_management_pages.dart';
import 'package:brd/Driver/DriverUnpaidSalaryPage.dart';
import 'package:brd/Driver/DriverServiceHistoryPage.dart';
import 'package:brd/hire_service/views/admin_initial_hire_page.dart';
import 'package:brd/hire_service/views/admin_notifications_page.dart';
import 'package:brd/hire_service/views/user_billing_page.dart';
import 'package:brd/hire_service/views/user_notifications_page.dart';
import 'package:brd/hire_service/views/user_service_page.dart';
import 'package:brd/hire_service/views/user_transactions_page.dart';
import 'package:brd/Driver/DriverSalaryHistoryPage.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routers {
  // ============================================================
  // USER AUTHENTICATION
  // ============================================================

  static const SIGNIN = '/login';

  static const SIGNUP = '/register';

  static const MOBILEOTP = '/mobile-otp';

  static const EMAILOTP = '/email-otp';

  static const LOGIN_USER_INFO = '/loginUserinfo';

  static const FORGETPASS = '/forget-password';

  static const SUBMITOTP = '/submit-otp';

  static const SETPASSWORD = '/set-password';

  // ============================================================
  // USER
  // ============================================================

  static const USERDASHBOARD = '/user-dashboard';

  static const USERPROFILE = '/user-profile';

  static const USERACCOUNT = '/user-account';

  static const ACCOUNT_VIEW = '/account-view';

  static const APPLICATION_PAGE = '/application-page';

  static const NOTIFICATIONS = '/notifications';
  static const MY_BILLING = '/my-billing';
  static const MY_DRIVER_SERVICE = '/my-driver-service';
  static const MY_TRANSACTIONS = '/my-transactions';
  static const ADMIN_INITIAL_HIRE = '/admin-initial-hire';
  static const ADMIN_NOTIFICATIONS = '/admin-notifications';
  static const ADMIN_BILLING = '/admin-billing';
  static const DRIVER_SALARY_HISTORY = '/driver-salary-history';
  static const DRIVER_UNPAID_SALARY = '/driver-unpaid-salary';
  static const DRIVER_SERVICE_HISTORY = '/driver-service-history';
  static const ADMIN_PENDING_SALARY = '/admin-pending-salary';
  static const ADMIN_PAID_SALARY = '/admin-paid-salary';
  static const ADMIN_USER_PENDING_SALARY = '/admin-user-pending-salary';
  static const ADMIN_USER_PAID_SALARY = '/admin-user-paid-salary';
  static const ADMIN_ACTIVE_SERVICES = '/admin-active-services';
  static const ADMIN_OPERATIONAL_LOCATIONS = '/admin-operational-locations';
  static const USER_SERVICE_HISTORY = '/user-service-history';

  static const USER_INFO_SUBMISSION =
      '/user_info_submission';

  // ============================================================
  // DRIVER
  // ============================================================

  static const DRIVER_DASHBOARD =
      '/driver-dashboard';

  static const DRIVER_REGISTRATION =
      '/driver-registration';

  static const DRIVER_EMAIL_VERIFICATION =
      '/driver_email_verification';

  static const DRIVER_FINAL_VERIFICATION =
      '/driver-final-verification';

  // ============================================================
  // ADMIN
  // ============================================================

  static const ADMIN_DASHBOARD =
      '/admin-dashboard';

  static const USERLIST_VIEW =
      '/userlist';

  static const DRIVERLSIT_VIEW =
      '/driverlist';

  static const DRIVERAPPLICATIONLSIT_VIEW =
      '/driver_application_profile_list';

  static const DRIVER_LIST =
      '/driver_list';
}

class Routes {
  static final routes = [

    // ==========================================================
    // USER AUTHENTICATION
    // ==========================================================

    GetPage(
      name: Routers.SIGNIN,
      page: () => const UserSignin(),
    ),

    GetPage(
      name: Routers.SIGNUP,
      page: () => signup.Usersignup(),
    ),

    GetPage(
      name: Routers.MOBILEOTP,
      page: () => Usermobileotpvarification(),
    ),

    GetPage(
      name: Routers.LOGIN_USER_INFO,
      page: () => Getloginuserinfo(),
    ),

    GetPage(
      name: Routers.EMAILOTP,
      page: () => Emailsendotp(),
    ),

    GetPage(
      name: Routers.FORGETPASS,
      page: () => Userforgetpassword(),
    ),

    GetPage(
      name: Routers.SUBMITOTP,
      page: () => Submitotpforgetpassword(),
    ),

    GetPage(
      name: Routers.SETPASSWORD,
      page: () => Setnewpassword(),
    ),

    // ==========================================================
    // USER / ADMIN GENERAL PAGES
    // ==========================================================

    GetPage(
      name: Routers.ACCOUNT_VIEW,
      page: () => Accountview(),
    ),

    GetPage(
      name: Routers.APPLICATION_PAGE,
      page: () => Applicationpage(),
    ),

    GetPage(
      name: Routers.NOTIFICATIONS,
      page: () => UserNotificationsPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.MY_BILLING,
      page: () => UserBillingPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.MY_DRIVER_SERVICE,
      page: () => UserServicePage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.MY_TRANSACTIONS,
      page: () => const UserTransactionsPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.ADMIN_INITIAL_HIRE,
      page: () => const AdminInitialHirePage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.ADMIN_NOTIFICATIONS,
      page: () => AdminNotificationsPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.ADMIN_BILLING,
      page: () => AdminBillingPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routers.DRIVER_SALARY_HISTORY,
      page: () => const DriverSalaryHistoryPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: Routers.DRIVER_UNPAID_SALARY, page: () => const DriverUnpaidSalaryPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.DRIVER_SERVICE_HISTORY, page: () => const DriverServiceHistoryPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.ADMIN_PENDING_SALARY, page: () => const AdminPendingSalaryPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.ADMIN_PAID_SALARY, page: () => const AdminPaidSalaryPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.ADMIN_USER_PENDING_SALARY, page: () => const AdminUserSalaryPage(paid:false), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.ADMIN_USER_PAID_SALARY, page: () => const AdminUserSalaryPage(paid:true), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.ADMIN_ACTIVE_SERVICES, page: () => const AdminActiveServicesPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.ADMIN_OPERATIONAL_LOCATIONS, page: () => const AdminOperationalLocationsPage(), middlewares: [AuthMiddleware()]),
    GetPage(name: Routers.USER_SERVICE_HISTORY, page: () => const OwnerServiceHistoryPage(), middlewares: [AuthMiddleware()]),

    GetPage(
      name: Routers.USERLIST_VIEW,
      page: () => Userlist(),
    ),

    GetPage(
      name: Routers.DRIVERLSIT_VIEW,
      page: () => Driverlist(),
    ),

    GetPage(
      name: Routers.DRIVERAPPLICATIONLSIT_VIEW,
      page: () => Driverapplicationview(),
    ),

    GetPage(
      name: Routers.DRIVER_LIST,
      page: () => Realdriverlist(),
    ),

    // ==========================================================
    // USER PROTECTED ROUTES
    // ==========================================================

    GetPage(
      name: Routers.USERACCOUNT,
      page: () => Useraccountpage(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),

    GetPage(
      name: Routers.USERDASHBOARD,
      page: () => Userdashboard(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),

    GetPage(
      name: Routers.USERPROFILE,
      page: () => Userprofile(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),

    GetPage(
      name: Routers.USER_INFO_SUBMISSION,
      page: () => submituserinfoform.Usersignup(),
    ),

    // ==========================================================
    // ADMIN DASHBOARD
    // ==========================================================

    GetPage(
      name: Routers.ADMIN_DASHBOARD,
      page: () => AdminDashboard(),
    ),

    // ==========================================================
    // DRIVER DASHBOARD
    // ==========================================================

    GetPage(
      name: Routers.DRIVER_DASHBOARD,
      page: () =>  DriverDashboard(),
    ),

    // ==========================================================
    // DRIVER REGISTRATION
    // ==========================================================

    GetPage(
      name: Routers.DRIVER_REGISTRATION,
      page: () => Driverregistration(),
    ),

    // ==========================================================
    // DRIVER EMAIL VERIFICATION
    // ==========================================================

    GetPage(
      name: Routers.DRIVER_EMAIL_VERIFICATION,
      page: () => Driveremailvarification(),
    ),

    // ==========================================================
    // DRIVER FINAL VERIFICATION
    // ==========================================================

    GetPage(
      name: Routers.DRIVER_FINAL_VERIFICATION,
      page: () => DriverFinalVerificationPart(),
    ),
  ];
}