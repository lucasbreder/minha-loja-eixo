import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_users.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/scaffold/views/base_scaffold.dart';

class PageUsers extends StatelessWidget {
  const PageUsers({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());
    controllerNav.activeMenu.value = 'Profissionais';
    return const BaseScaffold(
      title: 'Profissionais',
      children: [
        ListUsers(),
      ],
    );
  }
}
