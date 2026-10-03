import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:brd/GETX/Routes/get_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ============================================================
  // INITIALIZE GET STORAGE
  // ============================================================

  await GetStorage.init();

  // ============================================================
  // CREATE ONE GLOBAL USER CONTROLLER
  // ============================================================

  Get.put(
    Usergetxcontroller(),
    permanent: true,
  );

  // ============================================================
  // START APPLICATION
  // ============================================================

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ============================================================
  // GLOBAL USER CONTROLLER
  // ============================================================

  Usergetxcontroller get controller =>
      Get.find<Usergetxcontroller>();

  // ============================================================
  // APP TITLE
  // ============================================================

  final String appTitle = 'BRD';

  // ============================================================
  // INITIAL ROUTE
  // ============================================================

  String getInitialRoute() {
    final GetStorage box = GetStorage();

    // ------------------------------------------------------------
    // READ SAVED LOGIN INFORMATION
    // ------------------------------------------------------------

    final String token =
        box.read('access_token') ?? '';

    final bool isAdmin =
        box.read('is_admin') ?? false;

    final bool isStaff =
        box.read('is_staff') ?? false;

    final bool isDriver =
        box.read('is_driver') ?? false;

    debugPrint(
      '==============================================',
    );

    debugPrint(
      'BRD APPLICATION STARTUP',
    );

    debugPrint(
      'Access Token Exists: ${token.isNotEmpty}',
    );

    debugPrint(
      'Is Admin: $isAdmin',
    );

    debugPrint(
      'Is Staff: $isStaff',
    );

    debugPrint(
      'Is Driver: $isDriver',
    );

    debugPrint(
      '==============================================',
    );

    // ============================================================
    // NOT LOGGED IN
    // ============================================================

    if (token.isEmpty) {
      debugPrint(
        'No access token -> Login Page',
      );

      return Routers.LOGIN_USER_INFO;
    }

    // ============================================================
    // ADMIN / STAFF
    // ============================================================

    if (isAdmin || isStaff) {
      debugPrint(
        'Admin/Staff detected -> Admin Dashboard',
      );

      return Routers.ADMIN_DASHBOARD;
    }

    // ============================================================
    // DRIVER
    // ============================================================

    if (isDriver) {
      debugPrint(
        'Driver detected -> Driver Dashboard',
      );

      return Routers.DRIVER_DASHBOARD;
    }

    // ============================================================
    // NORMAL USER / CAR OWNER
    // ============================================================

    debugPrint(
      'Normal user detected -> User Dashboard',
    );

    return Routers.USERDASHBOARD;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          // ======================================================
          // APPLICATION INFORMATION
          // ======================================================

          title: appTitle,

          // ======================================================
          // LIGHT THEME
          // ======================================================

          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,

            scaffoldBackgroundColor:
                const Color(0xFFF7F7F9),

            primaryColor:
                const Color(0xFF800000),

            colorScheme:
                ColorScheme.fromSeed(
              seedColor:
                  const Color(0xFF800000),
              brightness:
                  Brightness.light,
            ),

            appBarTheme:
                const AppBarTheme(
              backgroundColor:
                  Color(0xFF800000),
              foregroundColor:
                  Colors.white,
              elevation: 0,
              centerTitle: true,
            ),

            cardColor:
                Colors.white,

            navigationBarTheme:
                const NavigationBarThemeData(
              backgroundColor:
                  Colors.white,
            ),

            listTileTheme:
                const ListTileThemeData(
              tileColor:
                  Colors.white,
            ),
          ),

          // ======================================================
          // DARK THEME
          // ======================================================

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,

            scaffoldBackgroundColor:
                const Color(0xFF121212),

            primaryColor:
                const Color(0xFF800000),

            colorScheme:
                ColorScheme.fromSeed(
              seedColor:
                  const Color(0xFF800000),
              brightness:
                  Brightness.dark,
            ),

            appBarTheme:
                const AppBarTheme(
              backgroundColor:
                  Color(0xFF5C0000),
              foregroundColor:
                  Colors.white,
              elevation: 0,
              centerTitle: true,
            ),

            cardColor:
                const Color(0xFF1E1E1E),

            navigationBarTheme:
                const NavigationBarThemeData(
              backgroundColor:
                  Color(0xFF1A1A1A),
            ),

            listTileTheme:
                const ListTileThemeData(
              tileColor:
                  Color(0xFF1E1E1E),
            ),
          ),

          // ======================================================
          // GLOBAL THEME MODE
          // ======================================================

          themeMode:
              controller.IsDarkMode.value
                  ? ThemeMode.dark
                  : ThemeMode.light,

          // ======================================================
          // INITIAL ROUTE
          // ======================================================

          initialRoute:
              getInitialRoute(),

          // ======================================================
          // ALL GETX ROUTES
          // ======================================================

          getPages:
              Routes.routes,
        );
      },
    );
  }
}