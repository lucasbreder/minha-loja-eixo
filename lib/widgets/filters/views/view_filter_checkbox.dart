import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';

class ListFilterCheckBox extends StatefulWidget {
  const ListFilterCheckBox(
      {required this.param, required this.controller, this.title, super.key});

  final String param;
  final dynamic controller;
  final String? title;

  @override
  State<ListFilterCheckBox> createState() => _ListFilterCheckBox();
}

class _ListFilterCheckBox extends State<ListFilterCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          widget.title != null
              ? Text(
                  widget.title!,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary),
                )
              : const SizedBox(),
          Checkbox(
            checkColor: Theme.of(context).colorScheme.primary,
            value: isChecked,
            onChanged: (bool? value) {
              value == true
                  ? widget.controller.queryParams.addAll({
                      widget.param: 1,
                    })
                  : widget.controller.queryParams.remove(widget.param);

              widget.controller
                  .filterItemsByQuery(params: widget.controller.queryParams);

              setState(() {
                isChecked = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
