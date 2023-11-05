import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/dashboard/views/dashboard_box.dart';
import 'package:minha_loja_eixo/components/dashboard/views/dashboard_deals_chart.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_last_deals.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_top_users.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/scaffold/views/base_scaffold.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());
    controllerNav.activeMenu.value = 'Dashboard';
    return BaseScaffold(
      title: 'Dashboard',
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          spacing: 40,
          runSpacing: 40,
          children: const [
            DashboardDealsChart(),
            DashboardBox(
              title: 'Últimas Vendas',
              child: ListLastDeals(
                limit: 5,
              ),
            ),
            DashboardBox(
              title: 'Top 5 Profissionais',
              child: ListTopUsers(
                limit: 5,
              ),
            ),
            DashboardBox(
              title: 'Pendências',
              child: ListLastDeals(
                noConfimed: true,
              ),
            ),
          ],
        )
      ],
    );
  }
}
