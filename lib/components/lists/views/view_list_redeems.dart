import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/filters/views/view_filter_per_page.dart';
import 'package:minha_loja_eixo/services/controller_redeems.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_redeem_item.dart';
import 'package:minha_loja_eixo/components/lists/views/view_pagination.dart';
import 'package:minha_loja_eixo/components/loader/views/Loader.dart';

class ListRedeems extends StatelessWidget {
  const ListRedeems({this.showFilters = false, super.key});

  final bool showFilters;

  @override
  Widget build(BuildContext context) {
    ControllerRedeem controller = Get.put(ControllerRedeem());
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showFilters
                ? Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Wrap(
                      direction: Axis.vertical,
                      spacing: 30,
                      children: [
                        ListFilterPerPage(
                          items: const [20, 30, 40],
                          defaultValue: 30,
                          controller: controller,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            controller.isLoading.value
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
                    : Wrap(
                        children: [
                          for (Map<String, dynamic> redeem
                              in controller.itemsList)
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  controller.filterItemsByQuery(
                                      params: {'userId': redeem['id']});
                                },
                                child: ListReedemItem(data: redeem),
                              ),
                            ),
                        ],
                      ),
            controller.pagesInfo.value.lastPage != null &&
                    controller.pagesInfo.value.lastPage! > 1
                ? Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Wrap(
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
                    ),
                  )
                : const SizedBox()
          ],
        ));
  }
}
