import 'dart:convert';

import 'package:brd/hire_service/models/billing_model.dart';
import 'package:brd/hire_service/models/driver_service_model.dart';
import 'package:brd/hire_service/models/notification_model.dart';
import 'package:brd/hire_service/models/transaction_model.dart';
import 'package:brd/hire_service/models/salary_payment_model.dart';
import 'package:brd/hire_service/models/unpaid_salary_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HireServiceApi {
  static const String baseUrl = 'https://nonideologically-minuscular-hoyt.ngrok-free.dev';
  final GetStorage box = GetStorage();

  String get token => (box.read('access_token') ?? '').toString();

  Map<String, String> get headers => {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  Future<dynamic> _request(String method, String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    late http.Response response;
    try {
      if (method == 'GET') {
        response = await http.get(uri, headers: headers);
      } else if (method == 'POST') {
        response = await http.post(uri, headers: headers, body: jsonEncode(body ?? {}));
      } else if (method == 'PATCH') {
        response = await http.patch(uri, headers: headers, body: jsonEncode(body ?? {}));
      } else {
        response = await http.delete(uri, headers: headers, body: jsonEncode(body ?? {}));
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }

    dynamic data;
    try {
      data = response.body.isEmpty ? <String, dynamic>{} : jsonDecode(response.body);
    } catch (_) {
      data = {'message': response.body};
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = data is Map ? (data['message'] ?? data['detail'] ?? data['error']) : null;
      throw Exception(message?.toString() ?? 'Request failed (${response.statusCode})');
    }
    return data;
  }

  Future<Map<String, dynamic>> createInitialHire({
    required String driverEmail,
    required String driverPhone,
    required String userEmail,
    required String userPhone,
    required double salary,
  }) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/initial-hire/create/', body: {
      'driver_email': driverEmail,
      'driver_phone_number': driverPhone,
      'user_email': userEmail,
      'user_phone_number': userPhone,
      'salary': salary,
    });
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> respondInitialHire(String uuid, String response) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/initial-hire/$uuid/respond/', body: {
      'response': response,
    });
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> confirmInitialHire(String uuid) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/initial-hire/$uuid/confirm/');
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> createDriverService({required String hireUuid}) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/driver-service/create/', body: {
      'hire_uuid': hireUuid,
    });
    return Map<String, dynamic>.from(data as Map);
  }

  Future<List<DriverServiceModel>> getServiceDurationHistory() async {
    final data = await _request('GET', '/dashboard/dashboard/driver-service/duration/history/');
    return _listFrom(data, ['history', 'services']).map(DriverServiceModel.fromJson).toList();
  }

  Future<Map<String, dynamic>> createMonthlyBilling(String serviceUuid) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/billing/monthly/create/', body: {
      'service_uuid': serviceUuid,
    });
    return Map<String, dynamic>.from(data as Map);
  }

  Future<Map<String, dynamic>> payBilling(String billingUuid, String transactionId) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/billing/$billingUuid/pay/', body: {
      'transaction_id': transactionId,
    });
    return Map<String, dynamic>.from(data as Map);
  }

  Future<List<BillingModel>> getMyBilling() async {
    final data = await _request('GET', '/dashboard/dashboard/billing/my/');
    return _listFrom(data, ['billing', 'billings', 'results']).map(BillingModel.fromJson).toList();
  }

  Future<List<BillingModel>> getAdminBilling() async {
    final data = await _request('GET', '/dashboard/dashboard/admin/billing/');
    return _listFrom(data, ['billing', 'billings', 'results']).map(BillingModel.fromJson).toList();
  }

  Future<List<TransactionModel>> getMyTransactions() async {
    final data = await _request('GET', '/dashboard/dashboard/transactions/my/');
    return _listFrom(data, ['transactions', 'results']).map(TransactionModel.fromJson).toList();
  }

  Future<List<TransactionModel>> getAdminTransactions() async {
    final data = await _request('GET', '/dashboard/dashboard/admin/transactions/');
    return _listFrom(data, ['transactions', 'results']).map(TransactionModel.fromJson).toList();
  }

  Future<List<SalaryPaymentModel>> getAdminSalaryPayments() async {
    final data = await _request('GET', '/dashboard/dashboard/admin/salary-payments/');
    return _listFrom(data, ['salary_payments', 'payments', 'results'])
        .map(SalaryPaymentModel.fromJson)
        .toList();
  }

  Future<Map<String, dynamic>> payDriverSalary({
    required String billingUuid,
    required String transactionId,
    required String paymentMethod,
    String? notes,
  }) async {
    final data = await _request(
      'POST',
      '/dashboard/dashboard/admin/salary-payments/create/',
      body: {
        'billing_uuid': billingUuid,
        'transaction_id': transactionId,
        'payment_method': paymentMethod,
        if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
      },
    );
    return Map<String, dynamic>.from(data as Map);
  }

  Future<List<UnpaidSalaryModel>> getAdminPendingDriverSalary() async {
    final data = await _request('GET', '/dashboard/dashboard/admin/salary-payments/pending/');
    return _listFrom(data, ['pending_salary', 'salary_payments', 'results']).map(UnpaidSalaryModel.fromJson).toList();
  }

  Future<List<UnpaidSalaryModel>> getMyUnpaidSalary() async {
    final data = await _request('GET', '/dashboard/dashboard/salary-payments/unpaid/');
    return _listFrom(data, ['unpaid_salary', 'pending_salary', 'results']).map(UnpaidSalaryModel.fromJson).toList();
  }

  Future<List<DriverServiceModel>> getAdminDriverServices() async {
    final data = await _request('GET', '/dashboard/dashboard/admin/driver-services/');
    return _listFrom(data, ['services', 'driver_services', 'results']).map(DriverServiceModel.fromJson).toList();
  }

  Future<Map<String, dynamic>> terminateDriverService(String serviceUuid) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/driver-service/$serviceUuid/terminate/');
    return Map<String, dynamic>.from(data as Map);
  }

  Future<List<DriverServiceModel>> getMyDriverServiceHistory() async {
    final data = await _request('GET', '/dashboard/dashboard/driver-service/history/');
    return _listFrom(data, ['services', 'history', 'driver_services', 'results']).map(DriverServiceModel.fromJson).toList();
  }

  Future<List<Map<String, dynamic>>> getAdminUserSalaryBillings(String state) async {
    final normalized = state == 'paid' ? 'paid' : 'pending';
    final data = await _request('GET', '/dashboard/dashboard/admin/user-salary/$normalized/');
    return _listFrom(data, ['billings', 'salary_billings', 'results']);
  }

  Future<List<SalaryPaymentModel>> getMySalaryPayments() async {
    final data = await _request('GET', '/dashboard/dashboard/salary-payments/my/');
    return _listFrom(data, ['salary_payments', 'payments', 'results'])
        .map(SalaryPaymentModel.fromJson)
        .toList();
  }

  Future<List<HireNotificationModel>> getMyNotifications() async {
    final data = await _request('GET', '/dashboard/dashboard/admin/notifications/');
    return _listFrom(data, ['notifications', 'results']).map(HireNotificationModel.fromJson).toList();
  }

  Future<Map<String, dynamic>> markNotificationRead(int notificationId) async {
    final data = await _request('POST', '/dashboard/dashboard/admin/notifications/$notificationId/read/');
    return Map<String, dynamic>.from(data as Map);
  }

  List<Map<String, dynamic>> _listFrom(dynamic data, List<String> keys) {
    if (data is List) {
      return data.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    }
    if (data is Map) {
      for (final key in keys) {
        if (data[key] is List) {
          return (data[key] as List).whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
        }
      }
    }
    debugPrint('Unexpected API list response: $data');
    return [];
  }
}
