import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_redeems.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/scaffold/views/base_scaffold.dart';

class PageReedems extends StatelessWidget {
  const PageReedems({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());
    controllerNav.activeMenu.value = 'Resgates';

    return const BaseScaffold(
      title: 'Resgates',
      children: [ListRedeems()],
    );
  }
}
