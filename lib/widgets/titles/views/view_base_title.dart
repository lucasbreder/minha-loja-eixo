import 'package:flutter/material.dart';

class BaseTitle extends StatelessWidget {
  const BaseTitle({
    Key? key,
    this.title,
    this.fontSize = 50.0,
  }) : super(key: key);

  final String? title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: fontSize! / 2),
      child: Text(
        title ?? '',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
