import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_checkbox.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_orderBy.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_per_page.dart';
import 'package:minha_loja_eixo/widgets/filters/views/view_filter_search.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_users.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_user_item.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_pagination.dart';
import 'package:minha_loja_eixo/widgets/loader/views/Loader.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerUsers controllerUsers = Get.put(ControllerUsers());
    ControllerDeals controllerDeals = Get.put(ControllerDeals());

    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Wrap(
                spacing: 30,
                runSpacing: 30,
                children: [
                  ListFilterSearch(
                    controller: controllerUsers,
                    placeholder: 'Busque por nome',
                  ),
                  ListFilterPerPage(
                    items: const [20, 24, 28, 32, 40],
                    defaultValue: 24,
                    controller: controllerUsers,
                  ),
                  ListFilterCheckBox(
                    title: 'Possui Foto?',
                    param: 'hasImage',
                    controller: controllerUsers,
                  ),
                  ListFilterOrderBy(
                    param: 'accounts.balance',
                    icon: Icons.leaderboard,
                    controller: controllerUsers,
                  ),
                  ListFilterOrderBy(
                    param: 'profiles.first_name',
                    icon: Icons.abc,
                    controller: controllerUsers,
                  )
                ],
              ),
            ),
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
                    : Wrap(
                        children: [
                          for (Map<String, dynamic> user
                              in controllerUsers.itemsList)
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  controllerDeals.filterItemsByQuery(
                                      params: {'userId': user['id']});
                                },
                                child: ListUserItem(data: user),
                              ),
                            ),
                        ],
                      ),
            controllerUsers.pagesInfo.value.lastPage != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Wrap(
                      spacing: 10,
                      children: [
                        for (var i = 1;
                            i <= controllerUsers.pagesInfo.value.lastPage!;
                            i++)
                          PaginationItem(
                              controller: controllerUsers, currentPage: i),
                        Text(
                            'Total: ${controllerUsers.pagesInfo.value.total.toString()}')
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ));
  }
}
