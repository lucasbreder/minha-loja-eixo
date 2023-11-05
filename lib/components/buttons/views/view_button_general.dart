import 'package:flutter/material.dart';

class ButtonGeneral extends StatelessWidget {
  const ButtonGeneral({
    required this.text,
    this.onTap,
    this.themeButton,
    super.key,
  });

  final Function()? onTap;
  final String text;
  final String? themeButton;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 15.0),
          padding: const EdgeInsets.fromLTRB(48.0, 8.0, 48.0, 8.0),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.primary),
              color: themeButton == 'light'
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(18.0))),
          child: Text(
            text,
            style: TextStyle(
                color: themeButton == 'light'
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                fontSize: 14.0,
                fontWeight: themeButton == 'light'
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
