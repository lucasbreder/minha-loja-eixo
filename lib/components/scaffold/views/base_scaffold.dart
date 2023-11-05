import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minha_loja_eixo/components/nav/views/view_featured_nav.dart';
import 'package:minha_loja_eixo/components/nav/views/view_nav.dart';
import 'package:minha_loja_eixo/components/nav/views/view_nav_mobile.dart';
import 'package:minha_loja_eixo/components/titles/views/view_base_title.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    this.showNav = true,
    this.title,
    required this.children,
    super.key,
  });

  final List<Widget> children;
  final bool? showNav;
  final String? title;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  String? token;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showNav!) isMobile ? const NavMobile() : const Nav(),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                constraints:
                    const BoxConstraints(minWidth: 100, maxWidth: 1100),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 20.0),
                      width: MediaQuery.of(context).size.width,
                      child: BaseTitle(title: widget.title),
                    ),
                    Column(
                      children: widget.children,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      width: MediaQuery.of(context).size.width / 0.9,
                      child: Text(
                        'Eixo© Todos os Direitos Reservados',
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.right,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    )
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
