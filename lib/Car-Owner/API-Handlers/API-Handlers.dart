import 'dart:convert';
import 'dart:ffi';
import 'package:brd/Car-Owner/WEBsocket/Websocket.dart';
import 'package:brd/Car-Owner/templets/UserSignIn.dart';
import 'package:brd/GETX/GetxFunctions/UserGetxController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

const String baseURL =
    "https://nonideologically-minuscular-hoyt.ngrok-free.dev";

class Apihandlers {
  static Future<Map<String, dynamic>> getUserInfo(String emailOrPhone) async {
    final uri = Uri.parse("$baseURL/myapp/myapp/getuserinfo/$emailOrPhone/");

    try {
      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = data["message"] ?? {};

        if (user == null) {
          throw Exception("user with this detail does not exist");
        }

        print({"username": user["fullname"], "email": user["email"]});

        return {"username": user["fullname"], "email": user["email"]};
      } else {
        throw Exception(data['message'] ?? "user not found");
      }
    } catch (e) {
      throw Exception("Server connection failed: $e");
    }
  }

  // Login-user

  static Future<Map<String, dynamic>> loginUserAPI(
    String email,
    String password,
  ) async {
    String endpoint = "/myapp/myapp/LoginUserView";
    final uri = Uri.parse('$baseURL$endpoint');

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = data['message'] ?? "";
        String accessToken = data['aceess_token'] ?? "";
        String refreshToken = data['refresh_token'] ?? "";
        bool is_staff = data['is_staff'] ?? false;
        bool is_admin = data['is_superuser'] ?? false;
        bool is_driver = data['is_driver'] ?? false;

        print(is_admin);
        print(is_staff);
        print(is_driver);

        final loginInfo = {
          'message': message,
          'access_token': accessToken,
          'refresh_token': refreshToken,
          'is_staff': is_staff,
          'is_admin': is_admin,
          'is_driver': is_driver,
        };

        debugPrint(loginInfo.toString());

        return loginInfo;
      } else {
        throw Exception("email or password is invalid");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static Future<Map<String, dynamic>> userregistration(
    String fullName,
    String email,
    String phone_number,
    String password,
  ) async {
    String endpoint = '/myapp/myapp/register';
    final uri = Uri.parse('$baseURL$endpoint');

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'phone_number': phone_number,
          'pasword': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = data['user'];
        final int id = user['id'];

        Future.microtask(() {
          Websocket().connect(id);
        });
        print("websocket connected");

        return {
          'id': user['id'],
          'fullName': user['fullName'],
          'email': user['email'],
          'phone_number': user['phone_number'],
          'status': user['status'],
        };
      } else {
        throw Exception(data['message'] ?? "Registration failed");
      }
    } catch (e) {
      throw Exception("Server error: $e");
    }
  }

  static Future<String> MobileVarificationApi(String phone, String otp) async {
    final String endpoint = "myapp/myapp/mobile-varification";

    final url = Uri.parse("$baseURL/$endpoint");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'phone': phone, 'otp': otp}),
      );
      if (response.statusCode == 200 || response.statusCode == 202) {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? "";
        return message;
      } else {
        throw Exception("OTP verification failed");
      }
    } catch (e) {
      throw Exception("Server error: $e");
    }
  }

  static Future<String> resendMobileVarification(String phone) async {
    final String endpoint = '/myapp/myapp/resend-phone-otp';
    final url = Uri.parse('$baseURL$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "otp resent successfully";
      } else {
        final data = jsonDecode(response.body);
        final String message = data['message'] ?? "Failed to resend OTP";
        Get.snackbar("Error", message);
        return message;
      }
    } catch (e) {
      throw Exception("Server error: $e");
    }
  }

  static Future<String> sendEmailOtp(String email) async {
    String endpoint = 'myapp/myapp/resend-email-otp';

    final url = Uri.parse('$baseURL/$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Email OTP sent successfully";
      } else {
        final data = jsonDecode(response.body);
        String message = data['message'] ?? "";
        Get.snackbar("Error", message);
        return message;
      }
    } catch (e) {
      throw Exception("Server error: $e");
    }
  }

  static Future<Map<String, dynamic>> emailVarification(
    String email,
    String otp,
  ) async {
    final String endpoint = '/myapp/myapp/email-verification';

    final url = Uri.parse('$baseURL$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('data is $data');
        final String message = data['message'] ?? "";
        final String accesstoken = data['access_token'] ?? "";
        final String refreshtoken = data['refresh_token'] ?? "";
        print('print accesstoken $accesstoken');
        return {
          'message': message,
          'access_token': accesstoken,
          'refresh_token': refreshtoken,
        };
      } else {
        return {'message': null};
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
      return {'message': "An error occurred"};
    }
  }

  static Future<Map<String, dynamic>> fetchuserporfile(String token) async {
  final String endpoint = '/myapp/myapp/profileview';
  final url = Uri.parse('$baseURL$endpoint');

  try {
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final user = data['user'] ?? {};
      final profile = user['profile']; // can be null

      print("Raw API response: $data");

      return {
        'profile_id': profile != null ? profile['id'] ?? 0 : 0,
        'userid': user['id'] ?? 0,
        'fullName': user['fullName'] ?? '',
        'email': user['email'] ?? '',
        'phone': user['phone'] ?? '',
        'bio': profile != null ? profile['bio'] ?? '' : '',
        'profilePicture': profile != null ? profile['profile_picture'] ?? '' : '',
      };
    } else {
      final data = jsonDecode(response.body);
      Get.snackbar("Error", data['message'] ?? "Failed to fetch profile");
      return {};
    }
  } catch (e) {
    print("API Error: $e");
    return {};
  }
}

  static Future<Map<String, dynamic>> userApplication(String token) async {
    String endpoint = '/myapp/myapp/get-orders';

    final url = Uri.parse('$baseURL$endpoint');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        print(data);

        int userid = data['serializer']['id'];
        String location = data['serializer']['location'];
        String salary = data['serializer']['salary'].toString();
        String experience = data['serializer']['experience'];
        String working_hours = data['serializer']['working_hour'];
        String contact_number = data['serializer']['contact_number'];
        String created_at = data['serializer']['created_at'];

        return {
          'id': userid,
          'location': location,
          'salary': salary,
          'experience': experience,
          'working_hours': working_hours,
          'contact_number': contact_number,
          'created_at': created_at,
        };
      } else {
        throw Exception("Failed to fetch user applications");
      }
    } catch (e) {
      print("Error fetching user applications: $e");
      return {};
    }
  }

  Future<bool> uploadProfile(
    String token,
    String bio,
    File profilePicture,
  ) async {
    String endpoint = '/myapp/myapp/upload-profile-picture';
    final url = Uri.parse('$baseURL$endpoint');

    try {
      var request = http.MultipartRequest('POST', url);

      // headers
      request.headers['Authorization'] = 'Bearer $token';

      // fields
      request.fields['bio'] = bio;

      // file
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_picture',
          profilePicture.path,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(responseBody);
        print("UPLOAD SUCCESS: $data");
        return true;
      } else {
        final data = jsonDecode(responseBody);

        Get.snackbar(
          "Error",
          data['message'] ?? "Failed to upload profile",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        print("UPLOAD ERROR: $data");
        return false;
      }
    } catch (e) {
      throw Exception("Failed to upload profile $e");
    }
  }

  Future<Map<String, dynamic>> uploadUserApplication({
    required String location,
    required String salary,
    required String experience,
    required String workingHour,
    required String token,
  }) async {
    const String endpoint = "myapp/myapp/makeorder";
    final url = Uri.parse('$baseURL/$endpoint');

    double driver_salary = double.tryParse(salary) ?? 0.0;

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "location": location,
          "salary": driver_salary,
          "experience": experience,
          "working_hour": workingHour,
        }),
      );

      // Safely decode JSON
      dynamic data;
      try {
        data = jsonDecode(response.body);
      } catch (_) {
        return {
          'error': 'Invalid JSON response',
          'statusCode': response.statusCode,
          'body': response.body,
        };
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data as Map<String, dynamic>;
      } else {
        throw Exception(data);
      }
    } catch (e) {
      return {'error': 'Connection failed', 'details': e.toString()};
    }
  }



  Future<Map<String, dynamic>> updateuserProfile(
    File profile_picture,
    String bio,
    String token,
  ) async {
    final endpont = "/myapp/myapp/update-profile";
    final url = Uri.parse('$baseURL$endpont');

    try {
      final request = http.MultipartRequest('PUT', url);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['bio'] = bio;
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_picture',
          profile_picture.path,
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(responseBody);
        return data;
      } else {
        throw Exception("failed to update");
      }
    } catch (e) {
      throw Exception("Error occured at $e");
    }
  }

  Usergetxcontroller controller = Usergetxcontroller();

  Future<Map<String, dynamic>> userForgetpassword(String value) async {
    String endpont = '/myapp/myapp/forgetpassword';
    final url = Uri.parse('$baseURL$endpont');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email_or_phone": value}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        final data = json.decode(response.body);
        String errorresponse = data['message'];
        return {'message': errorresponse};
      }
    } catch (e) {
      throw Exception("not ok $e");
    }
  }
}
