import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:minha_loja_eixo/widgets/forms/models/model_login.dart';

Future<Response> post(
    {required Map<String, String> data,
    required apiRoute,
    String? redirectRoute,
    String? successMessage,
    bool isLogin = false,
    BuildContext? context}) async {
  final request = MultipartRequest(
    "POST",
    Uri.parse(apiRoute),
  );

  const storage = FlutterSecureStorage();

  if (!isLogin) {
    String? token = await storage.read(key: 'token');

    request.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer $token',
    });
  }

  request.fields.addAll(data);

  var response = await request.send();
  var responsed = await http.Response.fromStream(response);

  if (response.statusCode == 200 && isLogin) {
    final logginInfo = Login.fromJson(jsonDecode(responsed.body));
    await storage.write(key: 'token', value: logginInfo.token);
    await storage.write(key: 'role', value: logginInfo.role.toString());
  }

  if (redirectRoute != null && context != null && response.statusCode == 200) {
    Navigator.pushNamed(context, redirectRoute);
  }
  return responsed;
}
