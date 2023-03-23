import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/widgets/nav/views/view_nav.dart';
import 'package:minha_loja_eixo/widgets/titles/views/view_base_title.dart';

class LoginScaffold extends StatefulWidget {
  const LoginScaffold({
    this.showNav = true,
    this.title,
    required this.children,
    super.key,
  });

  final List<Widget> children;
  final bool? showNav;
  final String? title;

  @override
  State<LoginScaffold> createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<LoginScaffold> {
  String? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (widget.showNav!) const Nav(),
            Center(
              heightFactor: 2,
              child: Container(
                width: MediaQuery.of(context).size.width / 0.9,
                constraints:
                    const BoxConstraints(minWidth: 100, maxWidth: 1100),
                child: Column(
                  children: [
                    Column(
                      children: widget.children,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
