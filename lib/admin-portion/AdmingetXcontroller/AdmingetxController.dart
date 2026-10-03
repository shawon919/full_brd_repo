import 'package:brd/admin-portion/Admin-templates/DriverApplicationView.dart';
import 'package:brd/admin-portion/Admin-templates/Driverlist.dart';
import 'package:brd/admin-portion/Admin-templates/RealDriverList.dart';
import 'package:brd/admin-portion/Admin-templates/UserList.dart';
import 'package:brd/admin-portion/Admin-templates/UserProfileView.dart';
import 'package:brd/admin-portion/AdminApiHandler/AdminApiHandler.dart';
import 'package:brd/admin-portion/AdminApiHandler/userListModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Admingetxcontroller extends GetxController {
  final box = GetStorage();

  // ============================================================
  // USER LIST
  // ============================================================

  RxList<Userlistmodel> allUser = <Userlistmodel>[].obs;
  RxList<Userlistmodel> user = <Userlistmodel>[].obs;

  RxBool is_loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchUserList() async {
    try {
      is_loading.value = true;

      Get.to(() => Userlist());

      final data =
          await Adminapihandler().UserViewList();

      user.assignAll(data);
      allUser.assignAll(data);

      print(user);
      print('the user list is $user');

    } catch (e) {

      print('$e');

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      is_loading.value = false;
    }
  }


  // ============================================================
  // DRIVER LIST
  // ============================================================

  RxList<dynamic> driverList = <dynamic>[].obs;

  void fetchDriveList() async {

    try {

      is_loading.value = true;

      Get.to(() => Driverlist());

      final data =
          await Adminapihandler().DriverViewList();

      if (data.isNotEmpty) {

        driverList.assignAll(data);

        print(
          "driver list: $driverList",
        );

      } else {

        driverList.clear();
      }

    } catch (e) {

      print(
        "Error: $e",
      );

    } finally {

      is_loading.value = false;
    }
  }


  // ============================================================
  // DRIVER PROFILE
  // ============================================================

  RxString DL_frontside = ''.obs;
  RxString DL_backside = ''.obs;
  RxString NID_backside = ''.obs;
  RxString NID_frontside = ''.obs;

  RxString fullname = ''.obs;
  RxString mobile = ''.obs;
  RxString email = ''.obs;

  RxInt driverId = 0.obs;

  void fetchdriverprofile(int id) async {

    try {

      is_loading.value = true;

      Get.to(
        () => Driverapplicationview(),
      );

      Map<String, dynamic> data =
          await Adminapihandler()
              .fetchDriverProfile(id);

      driverId.value =
          data["id"] ?? 0;

      fullname.value =
          data['fullname'] ?? '';

      email.value =
          data['email'] ?? '';

      mobile.value =
          data['mobile'] ?? '';

      DL_frontside.value =
          data['DL_frontside'] ?? '';

      DL_backside.value =
          data['DL_backside'] ?? '';

      NID_frontside.value =
          data['NID_frontside'] ?? '';

      NID_backside.value =
          data['NID_backside'] ?? '';

    } catch (e) {

      print('$e');

    } finally {

      is_loading.value = false;
    }
  }


  // ============================================================
  // DRIVER APPROVE
  // ============================================================

  void DriverApproveFunction(int id) async {

    try {

      is_loading.value = true;

      final data =
          await Adminapihandler()
              .driverApprovefunction(id);

      Get.snackbar(
        "Success",
        data['message'] ??
            "Driver approved",
        snackPosition:
            SnackPosition.BOTTOM,
        dismissDirection:
            DismissDirection.horizontal,
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition:
            SnackPosition.BOTTOM,
        dismissDirection:
            DismissDirection.horizontal,
      );

    } finally {

      is_loading.value = false;
    }
  }


  // ============================================================
  // DRIVER VIEW LIST
  // ============================================================

  RxString driver_DL_frontside = ''.obs;
  RxString driver_DL_backside = ''.obs;
  RxString driver_NID_backside = ''.obs;
  RxString driver_NID_frontside = ''.obs;

  RxString driver_fullname = ''.obs;
  RxString driver_mobile = ''.obs;
  RxString driver_email = ''.obs;
  RxString drive_user_id = ''.obs;


  void fetchDirverlist() async {

    try {

      is_loading.value = true;

      final data =
          await Adminapihandler()
              .fetchdriverlist();

      driver_DL_frontside.value =
          data['DL_frontside'] ?? '';

      driver_DL_backside.value =
          data['DL_backside'] ?? '';

      driver_NID_frontside.value =
          data['NID_frontside'] ?? '';

      driver_NID_backside.value =
          data['NID_backside'] ?? '';

      drive_user_id.value =
          data['user_id'].toString();

      driver_fullname.value =
          data['fullname'] ?? '';

      driver_mobile.value =
          data['mobile'] ?? '';

      driver_email.value =
          data['email'] ?? '';

    } catch (e) {

      throw Exception("$e");

    } finally {

      is_loading.value = false;
    }
  }


  // ============================================================
  // REAL DRIVER LIST
  // ============================================================

  RxBool isLoading = false.obs;

  RxList drivers = [].obs;

  List allDrivers = [];

  RxInt expandedIndex = (-1).obs;


  Future<void> loadDrivers() async {

    try {

      isLoading.value = true;

      Get.to(
        () => Realdriverlist(),
      );

      final data =
          await Adminapihandler()
              .fetchDriverList();

      drivers.assignAll(data);

      allDrivers = data;

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value = false;
    }
  }


  void toggleExpand(int index) {

    if (expandedIndex.value == index) {

      expandedIndex.value = -1;

    } else {

      expandedIndex.value = index;
    }
  }


  // ============================================================
  // DRIVER SEARCH
  // ============================================================

  TextEditingController searchController =
      TextEditingController();

  void searchDriver() {

    String query =
        searchController.text
            .trim()
            .toLowerCase();

    if (query.isEmpty) {

      drivers.assignAll(
        allDrivers,
      );

      return;
    }

    final filtered =
        allDrivers.where((driver) {

      final user =
          driver['user'] ?? {};

      String name =
          (user['fullName'] ?? "")
              .toString()
              .toLowerCase();

      final email =
          (
            user['email'] ??
            user['email_address'] ??
            user['mail'] ??
            ""
          )
              .toString()
              .trim()
              .toLowerCase();

      String phone =
          (user['phone'] ?? "")
              .toString()
              .toLowerCase();

      return name.contains(query) ||
          email.contains(query) ||
          phone.contains(query);

    }).toList();

    drivers.assignAll(
      filtered,
    );
  }


  void clearSearch() {

    searchController.clear();

    drivers.assignAll(
      allDrivers,
    );
  }


  // ============================================================
  // USER SEARCH
  // ============================================================

  TextEditingController usersearchController =
      TextEditingController();

  void searchUser() {

    final query =
        usersearchController.text
            .trim()
            .toLowerCase();

    if (query.isEmpty) {

      user.assignAll(
        allUser,
      );

      return;
    }

    final filteredList =
        allUser.where((u) {

      final name =
          u.fullName
              .toLowerCase();

      final email =
          u.email
              .toLowerCase();

      final phone =
          u.phone
              .toLowerCase();

      return name.contains(query) ||
          email.contains(query) ||
          phone.contains(query);

    }).toList();

    user.assignAll(
      filteredList,
    );
  }


  void clearuserSearch() {

    usersearchController.clear();

    user.assignAll(
      allUser,
    );
  }


  // ============================================================
  // SELECTED USER PROFILE
  // ============================================================

RxBool userProfileLoading = false.obs;

RxMap<String, dynamic> selectedUserProfile =
    <String, dynamic>{}.obs;


Future<void> fetchUserProfile(int id) async {

  try {

    userProfileLoading.value = true;

    selectedUserProfile.clear();

    final data =
        await Adminapihandler()
            .fetchUserProfile(id);

    selectedUserProfile.assignAll(
      data,
    );

  

  } catch (e) {

    Get.snackbar(
      "Error",
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );

  } finally {

    userProfileLoading.value = false;
  }
}


RxBool terminateLoading = false.obs;


Future<bool> terminateUser(
    int id,
    String password) async {

  try {

    terminateLoading.value = true;

    final data =
        await Adminapihandler()
            .terminateUser(
              id,
              password,
            );

    Get.snackbar(
      "Success",
      data['message'] ??
          "User terminated successfully",

      snackPosition:
          SnackPosition.BOTTOM,

      backgroundColor:
          const Color(0xFF4F46E5),

      colorText: Colors.white,
    );

    // Remove from displayed list
    user.removeWhere(
      (element) => element.id == id,
    );

    // Remove from original list
    allUser.removeWhere(
      (element) => element.id == id,
    );

    return true;

  } catch (e) {

    Get.snackbar(
      "Error",
      e.toString(),
      snackPosition:
          SnackPosition.BOTTOM,
    );

    return false;

  } finally {

    terminateLoading.value = false;
  }
}


  @override
  void onClose() {

    searchController.dispose();

    usersearchController.dispose();

    super.onClose();
  }
}