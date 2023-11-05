import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/services/controller_ranking.dart';
import 'package:minha_loja_eixo/components/lists/views/view_list_top_user_item.dart';
import 'package:minha_loja_eixo/components/loader/views/Loader.dart';

class ListTopUsers extends StatelessWidget {
  const ListTopUsers({super.key, this.limit});

  final int? limit;

  @override
  Widget build(BuildContext context) {
    ControllerUsersRanking controllerUsers = Get.put(ControllerUsersRanking());
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controllerUsers.isLoading.value
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Loader(),
                  ],
                )
              : controllerUsers.itemsList.isEmpty
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
                        for (Map<String, dynamic> user
                            in controllerUsers.itemsList.getRange(
                                0,
                                limit != null &&
                                        limit! <
                                            controllerUsers.itemsList.length
                                    ? limit!
                                    : controllerUsers.itemsList.length))
                          ListTopUserItem(data: user),
                      ],
                    )
        ],
      );
    });
  }
}
