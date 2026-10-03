import 'package:brd/hire_service/api/hire_service_api.dart';
import 'package:brd/hire_service/models/billing_model.dart';
import 'package:brd/hire_service/models/driver_service_model.dart';
import 'package:brd/hire_service/models/notification_model.dart';
import 'package:brd/hire_service/models/transaction_model.dart';
import 'package:brd/hire_service/models/salary_payment_model.dart';
import 'package:brd/hire_service/models/unpaid_salary_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HireServiceController extends GetxController {
  final HireServiceApi api = HireServiceApi();

  final isLoading = false.obs;
  final notifications = <HireNotificationModel>[].obs;
  final billings = <BillingModel>[].obs;
  final services = <DriverServiceModel>[].obs;
  final transactions = <TransactionModel>[].obs;
  final adminBillings = <BillingModel>[].obs;
  final adminTransactions = <TransactionModel>[].obs;
  final adminSalaryPayments = <SalaryPaymentModel>[].obs;
  final adminPendingSalaries = <UnpaidSalaryModel>[].obs;
  final myUnpaidSalaries = <UnpaidSalaryModel>[].obs;
  final adminDriverServices = <DriverServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;
      notifications.assignAll(await api.getMyNotifications());
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> respondToHire(String uuid, bool accepted) async {
    try {
      isLoading.value = true;
      final result = await api.respondInitialHire(uuid, accepted ? 'accepted' : 'rejected');
      Get.snackbar('Success', result['message']?.toString() ?? 'Response submitted', snackPosition: SnackPosition.BOTTOM);
      await loadNotifications();
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmHire(String uuid) async {
    try {
      isLoading.value = true;
      final result = await api.confirmInitialHire(uuid);
      Get.snackbar('Success', result['message']?.toString() ?? 'Hire confirmed', snackPosition: SnackPosition.BOTTOM);
      await loadNotifications();
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadBilling() async {
    try {
      isLoading.value = true;
      billings.assignAll(await api.getMyBilling());
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadServices() async {
    try {
      isLoading.value = true;
      services.assignAll(await api.getServiceDurationHistory());
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTransactions() async {
    try {
      isLoading.value = true;
      transactions.assignAll(await api.getMyTransactions());
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> payBilling(String uuid, String transactionId) async {
    try {
      isLoading.value = true;
      final result = await api.payBilling(uuid, transactionId);
      Get.snackbar('Payment submitted', result['message']?.toString() ?? 'Payment completed', snackPosition: SnackPosition.BOTTOM);
      await loadBilling();
      await loadTransactions();
      await loadNotifications();
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markRead(int id) async {
    try {
      await api.markNotificationRead(id);
      final index = notifications.indexWhere((n) => n.id == id);
      if (index >= 0) {
        final old = notifications[index];
        notifications[index] = HireNotificationModel(
          id: old.id,
          title: old.title,
          message: old.message,
          type: old.type,
          isRead: true,
          initialHireUuid: old.initialHireUuid,
          initialHireStatus: old.initialHireStatus,
          createdAt: old.createdAt,
        );
      }
    } catch (e) {
      _error(e);
    }
  }

  Future<void> loadAdminData() async {
    try {
      isLoading.value = true;
      adminBillings.assignAll(await api.getAdminBilling());
      adminTransactions.assignAll(await api.getAdminTransactions());
      adminSalaryPayments.assignAll(await api.getAdminSalaryPayments());
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> payDriverSalary({
    required String billingUuid,
    required String transactionId,
    required String paymentMethod,
    String? notes,
  }) async {
    try {
      isLoading.value = true;
      final result = await api.payDriverSalary(
        billingUuid: billingUuid,
        transactionId: transactionId,
        paymentMethod: paymentMethod,
        notes: notes,
      );
      Get.snackbar(
        'Salary Paid',
        result['message']?.toString() ?? 'Driver salary payment recorded.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await loadAdminData();
    } catch (e) {
      _error(e);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> loadSalaryData() async {
    try {
      isLoading.value=true;
      adminSalaryPayments.assignAll(await api.getAdminSalaryPayments());
      adminPendingSalaries.assignAll(await api.getAdminPendingDriverSalary());
    } catch(e) { _error(e); } finally { isLoading.value=false; }
  }

  Future<void> loadMySalaryData() async {
    try { myUnpaidSalaries.assignAll(await api.getMyUnpaidSalary()); } catch(e) { _error(e); }
  }

  Future<void> loadAdminDriverServices() async {
    try { isLoading.value=true; adminDriverServices.assignAll(await api.getAdminDriverServices()); } catch(e) { _error(e); } finally { isLoading.value=false; }
  }

  void _error(Object e) {
    Get.snackbar('Error', e.toString().replaceFirst('Exception: ', ''), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
  }
}
