import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Otherfuncion {
  final storage = FlutterSecureStorage();
  Future<void> saveToken(String token) async {
    await storage.write(key: "access_token", value: token);
    print("Token saved: $token");
  }
}
