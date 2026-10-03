import 'dart:convert';
import 'dart:ffi';

import 'package:brd/Car-Owner/WEBsocket/Websocket.dart';
import 'package:brd/Car-Owner/templets/UserSignIn.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:brd/admin-portion/AdminApiHandler/userListModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/instance_manager.dart';

import 'package:http/http.dart' as http;
import 'dart:io';

const String baseURL =
    "https://nonideologically-minuscular-hoyt.ngrok-free.dev";

const String mediaURL =
    'https://nonideologically-minuscular-hoyt.ngrok-free.dev';

Usergetxcontroller controller = Get.put(Usergetxcontroller());

String token = controller.box.read('access_token');

class Adminapihandler {

  // ============================================================
  // USER LIST
  // ============================================================

  Future<List<Userlistmodel>> UserViewList() async {
    final endpoint = '/dashboard/dashboard/UserList';

    try {
      final url = Uri.parse('$baseURL$endpoint');

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        final Map<String, dynamic> data =
            jsonDecode(response.body);

        final List<dynamic> datalist =
            data['users'] ?? data['users'] ?? [];

        print(datalist);

        return datalist.map((e) {
          return Userlistmodel.fromJson(e);
        }).toList();

      } else {
        throw Exception("failed to fetch data");
      }

    } catch (e) {
      throw Exception('failed $e');
    }
  }


  // ============================================================
  // DRIVER APPLICANTS
  // ============================================================

  Future<List<dynamic>> DriverViewList() async {

    final endpoint =
        '/dashboard/dashboard/DriverApplicants';

    final url = Uri.parse('$baseURL$endpoint');

    try {

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        final Map<String, dynamic> data =
            jsonDecode(response.body);

        print(data);

        final List<dynamic> datalist =
            data['Drivers'];

        print("the user data is $datalist");

        return datalist;

      } else {

        final Map<String, dynamic> data =
            jsonDecode(response.body);

        print(data);

        final List<dynamic> datalist =
            data['Drivers'];

        return datalist;
      }

    } catch (e) {
      throw Exception('e');
    }
  }


  // ============================================================
  // DRIVER PROFILE
  // ============================================================

  Future<Map<String, dynamic>> fetchDriverProfile(int id) async {

    final endpoint =
        '/dashboard/dashboard/driver-profile-view';

    final url =
        Uri.parse('$baseURL$endpoint?id=$id');

    try {

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {

        final json = jsonDecode(response.body);

        final data = json['data'];

        print(response.body);

        int id = data['id'];

        String fullname =
            data['FullName'];

        String email =
            data['email'] ?? '';

        String mobile =
            data['phone_number'] ?? '';

        String DL_frontside =
            data['DL_frontside'] != null
                ? mediaURL + data['DL_frontside']
                : '';

        String DL_backside =
            data['DL_Backside'] != null
                ? mediaURL + data['DL_Backside']
                : '';

        String NID_frontside =
            data['NID_frontside'] != null
                ? mediaURL + data['NID_frontside']
                : '';

        String NID_backside =
            data['NID_backside'] != null
                ? mediaURL + data['NID_backside']
                : '';

        return {

          'id': id,

          'fullname': fullname,

          'email': email,

          'mobile': mobile,

          'DL_frontside':
              DL_frontside,

          'DL_backside':
              DL_backside,

          'NID_frontside':
              NID_frontside,

          'NID_backside':
              NID_backside,
        };

      } else {

        print(
          "Error: ${response.statusCode}",
        );
      }

    } catch (e) {

      print(
        "Exception: $e",
      );
    }

    throw Exception(
      "failed to fetch",
    );
  }


  // ============================================================
  // DRIVER APPROVE
  // ============================================================

  Future<Map<String, dynamic>> driverApprovefunction(
      int id) async {

    final endpoint =
        '/dashboard/dashboard/DriverRegistrationApproved';

    final url =
        Uri.parse('$baseURL$endpoint');

    print(token);

    try {

      final response = await http.post(
        url,
        headers: {
          "Authorization":
              "Bearer $token",
          "Content-Type":
              "application/json",
        },
        body: jsonEncode({
          "id": id,
        }),
      );

      final data =
          jsonDecode(response.body);

      if (response.statusCode == 200) {

        print(data);

        return data;

      } else {

        throw Exception(
          data['message'] ??
              'Something went wrong',
        );
      }

    } catch (e) {

      throw Exception(
        "Exception: $e",
      );
    }
  }


  // ============================================================
  // DRIVER LIST
  // ============================================================

  Future<Map<String, dynamic>> fetchdriverlist() async {

    final endpoint =
        '/dashboard/dashboard/DriverViewList';

    final url =
        Uri.parse('$baseURL$endpoint');

    try {

      final response = await http.get(
        url,
        headers: {
          "Authorization":
              "Bearer $token",
        },
      );

      if (response.statusCode == 200) {

        final user =
            jsonDecode(response.body);

        Map<String, dynamic> data =
            user['user'];

        int user_id =
            data['id'];

        String fullname =
            data['fullName'];

        String email =
            data['email'];

        String mobile =
            data['phone'];

        String DL_frontside =
            user['DL_frontside'];

        String DL_backside =
            user['DL_Backside'];

        String NID_frontside =
            user['NID_frontside'];

        String NID_backside =
            user['NID_backside'];

        print(data);

        return {

          'user_id':
              user_id,

          'fullname':
              fullname,

          'email':
              email,

          'mobile':
              mobile,

          'DL_frontside':
              DL_frontside,

          'DL_backside':
              DL_backside,

          'NID_frontside':
              NID_frontside,

          'NID_backside':
              NID_backside,
        };

      } else {

        print(
          "Error: ${response.statusCode}",
        );
      }

    } catch (e) {

      print(
        "Exception: $e",
      );
    }

    throw Exception(
      "failed to fetch",
    );
  }


  // ============================================================
  // REQUEST LIST
  // ============================================================

  Future<List<dynamic>> fetchrequestList(
      int id) async {

    final endpoint =
        '/dashboard/dashboard/RequestList';

    final url =
        Uri.parse('$baseURL$endpoint');

    try {

      final response = await http.get(
        url,
        headers: {
          "Authorization":
              "Bearer $token",
        },
      );

      if (response.statusCode == 200) {

        final user =
            jsonDecode(response.body);

        List<dynamic> data =
            user['request'];

        print(data);

        return data;

      } else {

        print(
          "Error: ${response.statusCode}",
        );
      }

    } catch (e) {

      print(
        "Exception: $e",
      );
    }

    throw Exception(
      "failed to fetch",
    );
  }


  // ============================================================
  // DRIVER LIST - NEW VERSION
  // ============================================================

  Future<List<dynamic>> fetchDriverList() async {

    final url =
        Uri.parse(
          "$baseURL/dashboard/dashboard/DriverViewList",
        );

    try {

      final response = await http.get(
        url,
        headers: {
          "Accept":
              "application/json",

          "Authorization":
              "Bearer $token",
        },
      );

      final data =
          jsonDecode(response.body);

      if (response.statusCode == 200) {

        return data['Drivers'];

      } else {

        throw Exception(
          data['message'] ??
              "Failed to load drivers",
        );
      }

    } catch (e) {

      throw Exception(
        "Exception: $e",
      );
    }
  }



// ============================================================
// ADMIN - VIEW USER BY ID
// ============================================================

Future<Map<String, dynamic>> fetchUserProfile(int id) async {
  final endpoint = '/dashboard/dashboard/admin/user/$id/';

  final url = Uri.parse(
    '$baseURL$endpoint',
  );

  print("User profile URL: $url");

  try {
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("User profile status: ${response.statusCode}");
    print("User profile response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      if (data['user'] != null) {
        return Map<String, dynamic>.from(
          data['user'],
        );
      }

      return data;
    }

    throw Exception(
      "Unable to load user profile. "
      "Status: ${response.statusCode}",
    );
  } catch (e) {
    print("User profile error: $e");

    throw Exception(
      "Failed to load user profile: $e",
    );
  }
}


// ============================================================
// ADMIN - TERMINATE USER
// ============================================================

Future<Map<String, dynamic>> terminateUser(
  int id,
  String password,
) async {
  final endpoint =
      '/dashboard/dashboard/admin/user/$id/terminate/';

  final url = Uri.parse(
    '$baseURL$endpoint',
  );

  print("Terminate user URL: $url");

  try {
    final response = await http.delete(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "password": password,
      }),
    );

    print(
      "Terminate user status: ${response.statusCode}",
    );

    print(
      "Terminate user response: ${response.body}",
    );

    final Map<String, dynamic> data =
        jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['message'] ??
          "Unable to terminate user",
    );
  } catch (e) {
    print("Terminate user error: $e");

    throw Exception(
      "Failed to terminate user: $e",
    );
  }
}



Future<List<Map<String, dynamic>>> getAllUsers() async {
  final endpoint = '/dashboard/dashboard/admin/users/';
  final url = Uri.parse('$baseURL$endpoint');

  print("All users URL: $url");

  try {
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("All users status: ${response.statusCode}");
    print("All users response: ${response.body}");

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);

      if (data is List) {
        return data
            .map(
              (user) => Map<String, dynamic>.from(user),
            )
            .toList();
      }

      if (data is Map<String, dynamic>) {
        if (data['users'] is List) {
          return (data['users'] as List)
              .map(
                (user) =>
                    Map<String, dynamic>.from(user),
              )
              .toList();
        }
      }

      throw Exception(
        "Invalid users response format",
      );
    }

    throw Exception(
      "Unable to load users. Status: ${response.statusCode}",
    );
  } catch (e) {
    print("Get all users error: $e");
    throw Exception(
      "Failed to load users: $e",
    );
  }
}





 
}