import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja_eixo/components/dashboard/views/dashboard_graph_title_item.dart';
import 'package:minha_loja_eixo/services/controller_deals.dart';
import 'package:minha_loja_eixo/components/numbers/views/number_total.dart';

class DashboardDealsChart extends StatelessWidget {
  const DashboardDealsChart({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerDeals controllerDeals = Get.put(ControllerDeals());
    final NumberFormat formatterNumber =
        NumberFormat.currency(locale: "pt_BR", symbol: 'R\$');
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.all(45),
        child: Obx(
          () => Wrap(
            direction: Axis.horizontal,
            children: [
              controllerDeals.totalsInfo.value.totalDeals != null &&
                      controllerDeals.totalsInfo.value.totalPending != null
                  ? Wrap(
                      children: [
                        NumberTotal(
                          title: 'Total de Vendas da Temporada',
                          value: formatterNumber.format(
                              controllerDeals.totalsInfo.value.totalDeals),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 40,
                          height: 120,
                        ),
                        NumberTotal(
                          title: 'Pagamento pendente',
                          value: formatterNumber.format(
                              controllerDeals.totalsInfo.value.totalPending),
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 40,
                          height: 150,
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 50,
              ),
              controllerDeals.totalsInfo.value.totalByMonth != null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width > 980
                          ? MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.shortestSide
                          : MediaQuery.of(context).size.width - 100,
                      height: 200,
                      child: BarChart(
                        BarChartData(
                            borderData: FlBorderData(
                              border: const Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              ),
                            ),
                            gridData: FlGridData(
                              drawHorizontalLine: true,
                              drawVerticalLine: false,
                            ),
                            barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                    formatterNumber.format(rod.toY),
                                    const TextStyle(
                                        fontSize: 16, color: Colors.white));
                              },
                            )),
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 1:
                                          return const GraphTitleItem(
                                              title: 'Jan-23');
                                        case 2:
                                          return const GraphTitleItem(
                                              title: 'Fev-23');
                                        case 3:
                                          return const GraphTitleItem(
                                              title: 'Mar-23');
                                        case 4:
                                          return const GraphTitleItem(
                                              title: 'Abr-23');
                                        case 5:
                                          return const GraphTitleItem(
                                              title: 'Mai-22');
                                        case 6:
                                          return const GraphTitleItem(
                                              title: 'Jun-22');
                                        case 7:
                                          return const GraphTitleItem(
                                              title: 'Jul-22');
                                        case 8:
                                          return const GraphTitleItem(
                                              title: 'Ago-22');
                                        case 9:
                                          return const GraphTitleItem(
                                              title: 'Set-22');
                                        case 10:
                                          return const GraphTitleItem(
                                              title: 'Out-22');
                                        case 11:
                                          return const GraphTitleItem(
                                              title: 'Nov-22');
                                        case 12:
                                          return const GraphTitleItem(
                                              title: 'Dez-22');
                                        default:
                                          return const Text(" ");
                                      }
                                    }),
                              ),
                            ),
                            barGroups: [
                              for (dynamic key in controllerDeals
                                  .totalsInfo.value.totalByMonth!.keys)
                                BarChartGroupData(
                                  x: int.parse(key),
                                  barRods: [
                                    BarChartRodData(
                                      fromY: 0,
                                      toY: controllerDeals
                                          .totalsInfo.value.totalByMonth![key],
                                      width: MediaQuery.of(context).size.width <
                                              900
                                          ? 10
                                          : 30,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ],
                                ),
                            ]),
                        swapAnimationDuration:
                            const Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear, // Optional
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ));
  }
}
