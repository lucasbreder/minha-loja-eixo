import 'package:flutter/material.dart';

class PaginationItem extends StatelessWidget {
  const PaginationItem({
    Key? key,
    required this.controller,
    required this.currentPage,
  }) : super(key: key);

  final dynamic controller;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.queryParams.addAll({'page': currentPage});

        controller.filterItemsByQuery(params: controller.queryParams);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          currentPage.toString(),
          style: TextStyle(
            fontWeight: currentPage == controller.pagesInfo.value.currentPage
                ? FontWeight.bold
                : FontWeight.normal,
            color: currentPage == controller.pagesInfo.value.currentPage
                ? Theme.of(context).colorScheme.primary
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
