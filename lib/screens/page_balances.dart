import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/scaffold/views/base_scaffold.dart';

class PageBalances extends StatelessWidget {
  const PageBalances({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());
    controllerNav.activeMenu.value = 'Balanços';
    return const BaseScaffold(
      title: 'Balanços',
      children: [],
    );
  }
}
