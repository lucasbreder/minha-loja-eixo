import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/widgets/buttons/views/view_button_general.dart';

class NavFeatured extends StatelessWidget {
  const NavFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
      child: Row(
        children: [
          ButtonGeneral(
            text: 'Cadastrar Venda',
            onTap: (() {
              Navigator.pushNamed(context, 'cadastrar-venda');
            }),
          ),
        ],
      ),
    );
  }
}
