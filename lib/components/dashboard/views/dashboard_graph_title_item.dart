import 'package:flutter/material.dart';

class GraphTitleItem extends StatelessWidget {
  const GraphTitleItem({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xff68737d),
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width < 900 ? 4 : 12,
        ),
      ),
    );
  }
}
