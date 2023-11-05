import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/details/views/detail_user.dart';
import 'package:minha_loja_eixo/components/forms/controllers/get.dart';
import 'package:minha_loja_eixo/components/loader/views/Loader.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/scaffold/views/base_scaffold.dart';

class PageUser extends StatefulWidget {
  const PageUser({required this.userId, super.key});

  final int userId;

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    dynamic userData =
        await get(apiRoute: 'https://api.eixo.site/user/${widget.userId}');

    setState(() {
      _user = jsonDecode(userData.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());
    controllerNav.activeMenu.value = 'Profissionais';
    return BaseScaffold(
      children: [
        _user.isNotEmpty ? DetailUser(data: _user) : const Loader(),
      ],
    );
  }
}
