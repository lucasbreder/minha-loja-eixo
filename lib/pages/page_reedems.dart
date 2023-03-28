import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_redeems.dart';
import 'package:minha_loja_eixo/widgets/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/widgets/scaffold/views/base_scaffold.dart';

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
