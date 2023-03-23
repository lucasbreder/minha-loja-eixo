import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_users.dart';
import 'package:minha_loja_eixo/widgets/scaffold/views/base_scaffold.dart';

class PageUsers extends StatelessWidget {
  const PageUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      title: 'Profissionais',
      children: [
        ListUsers(apiRoute: 'https://api.eixo.site/allUsers'),
      ],
    );
  }
}
