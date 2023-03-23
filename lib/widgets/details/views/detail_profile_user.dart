import 'package:flutter/material.dart';

class DetailProfileUser extends StatelessWidget {
  const DetailProfileUser({required this.title, this.text, super.key});

  final String title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    String? textSanitized = text != null ? text!.trim() : null;

    if (textSanitized != null && textSanitized.isNotEmpty) {
      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text!,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
