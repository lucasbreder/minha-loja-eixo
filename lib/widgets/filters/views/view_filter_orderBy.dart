import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';

class ListFilterOrderBy extends StatefulWidget {
  const ListFilterOrderBy(
      {required this.param,
      required this.icon,
      required this.controller,
      super.key});

  final String param;
  final dynamic controller;
  final IconData icon;

  @override
  State<ListFilterOrderBy> createState() => _ListFilterOrderBy();
}

class _ListFilterOrderBy extends State<ListFilterOrderBy> {
  bool isAsc = false;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                if (!isEnabled) {
                  setState(() {
                    isEnabled = true;
                  });
                  widget.controller.queryParams
                      .addAll({'orderBy': widget.param, 'sort': 'desc'});
                  await widget.controller.filterItemsByQuery(
                      params: widget.controller.queryParams);
                } else {
                  if (!isAsc) {
                    setState(() {
                      isAsc = !isAsc;
                    });
                    widget.controller.queryParams
                        .addAll({'orderBy': widget.param, 'sort': 'asc'});
                    await widget.controller.filterItemsByQuery(
                        params: widget.controller.queryParams);
                  } else {
                    setState(() {
                      isAsc = false;
                      isEnabled = false;
                    });
                    widget.controller.queryParams.remove('orderBy');
                    widget.controller.queryParams.remove('sort');
                    await widget.controller.filterItemsByQuery(
                        params: widget.controller.queryParams);
                  }
                }
              },
              child: Wrap(
                children: [
                  Icon(
                    widget.icon,
                    color: isEnabled
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[400],
                  ),
                  Icon(
                    isAsc
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 20,
                    color: isEnabled
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[400],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
