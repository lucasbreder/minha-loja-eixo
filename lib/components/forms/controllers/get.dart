import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Response> get(
    {required apiRoute, String? successMessage, BuildContext? context}) async {
  final request = MultipartRequest(
    "GET",
    Uri.parse(apiRoute),
  );

  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');

  request.headers.addAll({
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer $token',
  });

  var response = await request.send();
  var responsed = await http.Response.fromStream(response);

  return responsed;
}
