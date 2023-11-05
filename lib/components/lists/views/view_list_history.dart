import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/filters/views/view_filter_per_page.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_history_item.dart';
import 'package:minha_loja_eixo/services/controller_history.dart';
import 'package:minha_loja_eixo/components/lists/views/view_pagination.dart';
import 'package:minha_loja_eixo/components/loader/views/Loader.dart';

class ListHistory extends StatelessWidget {
  const ListHistory({this.showFilters = false, super.key});

  final bool showFilters;

  @override
  Widget build(BuildContext context) {
    ControllerHistory controller = Get.put(ControllerHistory());
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
                ? const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Loader(),
                    ],
                  )
                : controller.itemsList.isEmpty
                    ? const Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nenhum histórico encontrado",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Wrap(
                        children: [
                          for (Map<String, dynamic> history
                              in controller.itemsList)
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  controller.filterItemsByQuery(
                                      params: {'userId': history['id']});
                                },
                                child: ListHistoryItem(data: history),
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
