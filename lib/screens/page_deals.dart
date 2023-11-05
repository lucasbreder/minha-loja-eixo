import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_deals.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/scaffold/views/base_scaffold.dart';

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
