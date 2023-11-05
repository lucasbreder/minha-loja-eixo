import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/buttons/views/view_button_general.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';

class NavFeatured extends StatelessWidget {
  const NavFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerNav controllerNav = Get.put(ControllerNav());

    return ButtonGeneral(
      text: 'Cadastrar Venda',
      themeButton:
          controllerNav.activeMenu.value == 'Cadastrar Venda' ? 'light' : '',
      onTap: (() {
        Navigator.pushNamed(context, 'cadastrar-venda');
      }),
    );
  }
}
