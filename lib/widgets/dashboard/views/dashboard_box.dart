import 'package:flutter/material.dart';

class DashboardBox extends StatelessWidget {
  const DashboardBox(
      {required this.child, this.title, this.backgroundColor, super.key});

  final Widget child;
  final Color? backgroundColor;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 15),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(45),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
