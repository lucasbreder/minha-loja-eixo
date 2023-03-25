import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_by_store.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_checkbox.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_orderBy.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_per_page.dart';
import 'package:minha_loja_eixo/widgets/helpers/check_admin_role.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_deal.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_deals_item.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_pagination.dart';
import 'package:minha_loja_eixo/widgets/loader/views/Loader.dart';
import 'package:minha_loja_eixo/widgets/numbers/views/number_total.dart';

class ListDeals extends StatefulWidget {
  const ListDeals(
      {this.showTotal = false,
      this.showFilters = false,
      this.showPagination = false,
      this.noConfimed = false,
      this.limit,
      super.key});

  final bool showTotal;
  final bool showFilters;
  final bool showPagination;
  final bool noConfimed;
  final int? limit;

  @override
  State<ListDeals> createState() => _ListDealsState();
}

class _ListDealsState extends State<ListDeals> {
  bool isAdmin = false;

  checkIsAdmin() async {
    bool isAdminToken = await checkAdminRole();
    setState(() {
      isAdmin = isAdminToken;
    });
  }

  @override
  void initState() {
    checkIsAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());

    final NumberFormat formatterNumber =
        NumberFormat.currency(locale: "pt_BR", symbol: 'R\$');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => controller.totalsInfo.value.totalDeals != null &&
                  controller.totalsInfo.value.totalDealsUnconfirmed != null &&
                  controller.totalsInfo.value.totalPending != null &&
                  widget.showTotal
              ? Wrap(
                  spacing: 30,
                  children: [
                    NumberTotal(
                      title: 'Total da temporada',
                      value: formatterNumber
                          .format(controller.totalsInfo.value.totalDeals),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    NumberTotal(
                      title: 'Total de vendas não confirmadas',
                      value: formatterNumber.format(
                          controller.totalsInfo.value.totalDealsUnconfirmed!),
                      color: Colors.orange,
                    ),
                    NumberTotal(
                      title: 'Pagamento pendente',
                      value: formatterNumber
                          .format(controller.totalsInfo.value.totalPending),
                      color: Colors.red,
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: widget.showFilters
              ? Wrap(
                  spacing: 30,
                  children: [
                    const ListFilterByStore(),
                    ListFilterPerPage(
                      items: const [20, 30, 40, 50],
                      defaultValue: 30,
                      controller: controller,
                    ),
                    ListFilterCheckBox(
                      title: "Não Confirmada?",
                      param: 'noConfirmed',
                      controller: controller,
                    ),
                    ListFilterOrderBy(
                      param: 'value',
                      icon: Icons.attach_money,
                      controller: controller,
                    ),
                    ListFilterOrderBy(
                      param: 'created_at',
                      icon: Icons.date_range,
                      controller: controller,
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        Obx(
          (() => controller.isLoading.value
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Loader(),
                  ],
                )
              : controller.itemsList.isEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Nada Encontrado",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        for (Map<String, dynamic> deal in controller.itemsList
                            .where((element) {
                              Deal deal = Deal.fromJson(element);

                              if (widget.noConfimed) {
                                return deal.isConfirmed == false;
                              }
                              return true;
                            })
                            .toList()
                            .getRange(
                                0,
                                widget.limit != null
                                    ? widget.limit!
                                    : controller.itemsList.length))
                          ListDealsItem(data: deal),
                        widget.showPagination
                            ? Wrap(
                                spacing: 10,
                                children: [
                                  for (var i = 1;
                                      i <= controller.pagesInfo.value.lastPage!;
                                      i++)
                                    PaginationItem(
                                        controller: controller, currentPage: i),
                                  Text(
                                      'Total: ${controller.pagesInfo.value.total.toString()}')
                                ],
                              )
                            : const SizedBox(),
                      ],
                    )),
        ),
      ],
    );
  }
}
