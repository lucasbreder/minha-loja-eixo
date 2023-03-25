import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_deal.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_deals_item.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_last_deals_item.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_pagination.dart';
import 'package:minha_loja_eixo/widgets/loader/views/Loader.dart';

class ListLastDeals extends StatelessWidget {
  const ListLastDeals({this.noConfimed = false, this.limit, super.key});

  final bool noConfimed;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          (() {
            List filteredList = controller.itemsList.where((element) {
              Deal deal = Deal.fromJson(element);

              if (noConfimed) {
                return deal.isConfirmed == false;
              }
              return true;
            }).toList();

            return controller.isLoading.value
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
                          for (Map<String, dynamic> deal
                              in filteredList.getRange(
                                  0,
                                  limit != null && limit! < filteredList.length
                                      ? limit!
                                      : filteredList.length))
                            ListLastDealsItem(
                              data: deal,
                              noConfimed: noConfimed,
                            ),
                        ],
                      );
          }),
        ),
      ],
    );
  }
}
