import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> checkAdminRole() async {
  const storage = FlutterSecureStorage();
  String? role = await storage.read(key: 'role');

  return role == "4" ? true : false;
}
