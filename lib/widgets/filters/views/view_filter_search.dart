import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_users.dart';

class ListFilterSearch extends StatelessWidget {
  const ListFilterSearch(
      {required this.controller, required this.placeholder, super.key});

  final dynamic controller;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
                label: Text(placeholder),
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                )),
            showCursor: true,
            onChanged: (value) {
              if (value.length > 3) {
                controller.queryParams.addAll({
                  's': value,
                });
                controller.filterItemsByQuery(params: controller.queryParams);
              }
              if (value.isEmpty) {
                controller.loadAllItems();
              }
            },
          )
        ],
      ),
    );
  }
}
