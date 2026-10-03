import 'dart:ffi';

import 'package:flutter/material.dart';

class Userlistmodel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
 

  Userlistmodel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    
  });

  factory Userlistmodel.fromJson(Map<String, dynamic> json) {
    return Userlistmodel(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "fullName": fullName, "email": email, "phone": phone,};
  }
}
