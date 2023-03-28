import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_stores.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_store.dart';

class ListFilterPerPage extends StatefulWidget {
  const ListFilterPerPage(
      {required this.items,
      required this.defaultValue,
      required this.controller,
      super.key});

  final List items;
  final int defaultValue;
  final dynamic controller;

  @override
  State<ListFilterPerPage> createState() => _ListFilterPerPage();
}

class _ListFilterPerPage extends State<ListFilterPerPage> {
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          "Por Página:",
          style: TextStyle(
              fontSize: 15, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.library_books,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          alignment: AlignmentDirectional.center,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Bahnschrift',
          ),
          onChanged: (value) async {
            int perPageInt = int.parse(value.toString());

            widget.controller.queryParams.addAll({
              'perPage': perPageInt,
              'page': 1,
            });

            setState(() {
              dropdownValue = perPageInt.toString();
            });

            widget.controller
                .filterItemsByQuery(params: widget.controller.queryParams);
          },
          value: dropdownValue != ''
              ? dropdownValue
              : widget.defaultValue.toString(),
          items: [
            for (dynamic item in widget.items)
              DropdownMenuItem<String>(
                value: item.toString(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
