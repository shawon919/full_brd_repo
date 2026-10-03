import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'storage_service_cached.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:brd/GETX/Routes/get_routes.dart';

class AuthMiddleware extends GetMiddleware {
  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    final token = box.read<String>('access_token');

    // Not logged in → go to login
    if ((token == null || token.isEmpty) &&
        route != Routers.SIGNIN) {
      return const RouteSettings(name: Routers.LOGIN_USER_INFO);
    }

    // Already logged in → block login page
    if (token != null && token.isNotEmpty &&
        route == Routers.SIGNIN) {
      return const RouteSettings(name: Routers.USERDASHBOARD);
    }

    return null;
  }
}