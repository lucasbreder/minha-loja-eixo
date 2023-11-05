import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/services/controller_deals.dart';
import 'package:minha_loja_eixo/services/controller_redeems.dart';
import 'package:minha_loja_eixo/services/controller_users.dart';
import 'package:minha_loja_eixo/components/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/components/nav/views/view_featured_nav.dart';

class NavMobile extends StatelessWidget {
  const NavMobile({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerDeals controllerDeals = Get.put(ControllerDeals());
    ControllerUsers controllerUsers = Get.put(ControllerUsers());
    ControllerRedeem controllerRedeems = Get.put(ControllerRedeem());
    ControllerNav controllerNav = Get.put(ControllerNav());

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 1, color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
      padding: const EdgeInsets.all(50),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        runAlignment: WrapAlignment.spaceBetween,
        alignment: WrapAlignment.spaceBetween,
        spacing: 30,
        children: [
          PopupMenuButton<MouseRegion>(
            offset: const Offset(0, 20),
            icon: const Icon(Icons.menu),
            position: PopupMenuPosition.under,
            color: Theme.of(context).colorScheme.primary,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<MouseRegion>(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (() {
                      controllerDeals.queryParams.clear();
                      controllerDeals.filterItemsByQuery(
                          params: controllerDeals.queryParams);
                      Navigator.pushNamed(context, 'dashboard');
                    }),
                    child: const Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              PopupMenuItem<MouseRegion>(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (() {
                      controllerDeals.queryParams.clear();
                      controllerDeals.filterItemsByQuery(
                          params: controllerDeals.queryParams);
                      Navigator.pushNamed(context, 'vendas');
                    }),
                    child: const Text(
                      'Vendas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              PopupMenuItem<MouseRegion>(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (() {
                      controllerUsers.queryParams.clear();
                      controllerUsers.filterItemsByQuery(
                          params: controllerUsers.queryParams);
                      Navigator.pushNamed(context, 'profissionais');
                    }),
                    child: const Text(
                      'Profissionais',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              PopupMenuItem<MouseRegion>(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (() {
                      controllerRedeems.queryParams.clear();
                      controllerRedeems.filterItemsByQuery(
                          params: controllerUsers.queryParams);
                      Navigator.pushNamed(context, 'resgates');
                    }),
                    child: const Text(
                      'Resgates',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              PopupMenuItem<MouseRegion>(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (() {
                      controllerRedeems.queryParams.clear();
                      controllerRedeems.filterItemsByQuery(
                          params: controllerUsers.queryParams);
                      Navigator.pushNamed(context, 'cadastrar-venda');
                    }),
                    child: const Text(
                      'Cadastrar Venda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              PopupMenuItem<MouseRegion>(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        const storage = FlutterSecureStorage();
                        storage.deleteAll();
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            'assets/images/eixo_brand.svg',
            semanticsLabel: 'Eixo',
            width: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          Obx(() {
            controllerNav.getBrand();
            return controllerNav.brand.value.isNotEmpty
                ? Image.network(
                    controllerNav.brand.value,
                    width: 90,
                    height: 50,
                    fit: BoxFit.contain,
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
