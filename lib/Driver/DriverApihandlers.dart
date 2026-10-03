import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String baseURL = "https://nonideologically-minuscular-hoyt.ngrok-free.dev";

class DriverApihandler {
  Future<Map<String, dynamic>> driverRegister({
    required String fullName,
    required String email,
    required String description,
    required String phoneNumber,
    required String password,
    required File dlFront,
    required File dlBack,
    required File nidFront,
    required File nidBack,
    required File cvFile,
  }) async {
    final url = Uri.parse("$baseURL/driver/driver/driver-registration");

    try {
      var request = http.MultipartRequest("POST", url);

      // Headers (ONLY if needed)
      request.headers.addAll({"Accept": "application/json"});

      // Text fields
      request.fields['FullName'] = fullName;
      request.fields['email'] = email;
      request.fields['describtions'] = description;
      request.fields['phone_number'] = phoneNumber;
      request.fields['password'] = password;

      // Image fields
      request.files.add(
        await http.MultipartFile.fromPath('DL_frontside', dlFront.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('DL_Backside', dlBack.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('NID_frontside', nidFront.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('NID_backside', nidBack.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('CV_field', cvFile.path),
      );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      final data = jsonDecode(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? "Registration failed");
      }
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }

  Future<Map<String, dynamic>> verifyDriverPhone({
    required String phone,
    required String otp,
  }) async {
    final url = Uri.parse("$baseURL/driver/driver/driver-phone-varification");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"phone": phone, "otp": otp}),
      );

      final data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? "Verification failed");
      }
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }



  Future<Map<String, dynamic>> driverEmailVerification({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse("$baseURL/driver/driver/driver-email-varification");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"email": email, "otp": otp}),
      );

      final data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? "Verification failed");
      }
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }






  Future<Map<String, dynamic>> DriverEmailOtpsend({
    required String email,
  }) async {
    final url = Uri.parse("$baseURL/driver/driver/driver-resend-email");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"email": email, }),
      );

      final data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? "otp sent failed");
      }
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }


   static Future<Map<String, dynamic>> fetchDriverProfile(
    String accessToken,
  ) async {
    const String endpoint = '/driver/driver/driver-profile';

    final Uri url = Uri.parse('$baseURL$endpoint');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic decodedData = jsonDecode(response.body);

      if (decodedData is! Map<String, dynamic>) {
        throw Exception('Invalid driver profile response.');
      }

      final dynamic profileData = decodedData['profile'];

      if (profileData is! Map<String, dynamic>) {
        throw Exception('Driver profile data not found.');
      }

      return Map<String, dynamic>.from(profileData);
    }

    if (response.statusCode == 401) {
      throw Exception('Unauthorized. Please login again.');
    }

    if (response.statusCode == 403) {
      throw Exception(
        'You do not have permission to access the driver profile.',
      );
    }

    throw Exception(
      'Failed to load driver profile. '
      'Status code: ${response.statusCode}',
    );
  }


  
}
