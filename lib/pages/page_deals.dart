import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_deals.dart';
import 'package:minha_loja_eixo/widgets/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/widgets/scaffold/views/base_scaffold.dart';

class PageSeals extends StatefulWidget {
  const PageSeals({super.key});

  @override
  State<PageSeals> createState() => _PageSealsState();
}

class _PageSealsState extends State<PageSeals> {
  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());
    controllerNav.activeMenu.value = 'Vendas';
    return const BaseScaffold(
      title: 'Vendas',
      children: [
        ListDeals(
          showFilters: true,
          showTotal: true,
          showPagination: true,
        ),
      ],
    );
  }
}
