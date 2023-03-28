import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_redeems.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_users.dart';
import 'package:minha_loja_eixo/widgets/nav/controllers/controller_nav.dart';
import 'package:minha_loja_eixo/widgets/nav/views/view_featured_nav.dart';

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerDeals controllerDeals = Get.put(ControllerDeals());
    ControllerUsers controllerUsers = Get.put(ControllerUsers());
    ControllerRedeem controllerRedeems = Get.put(ControllerRedeem());
    ControllerNav controllerNav = Get.put(ControllerNav());

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 45.0, 0, 45.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 1.0,
          ),
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 5.0,
          ),
        ),
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 0.9,
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 1100),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/eixo_brand.svg',
                      semanticsLabel: 'Eixo',
                      width: 120,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (() {
                          controllerDeals.queryParams.clear();
                          controllerDeals.filterItemsByQuery(
                              params: controllerDeals.queryParams);
                          Navigator.pushNamed(context, 'dashboard');
                        }),
                        child: Text('Dashboard',
                            style: TextStyle(
                                color: controllerNav.activeMenu.value ==
                                        'Dashboard'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary)),
                      ),
                    ),
                    const NavSeparator(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (() {
                          controllerDeals.queryParams.clear();
                          controllerDeals.filterItemsByQuery(
                              params: controllerDeals.queryParams);
                          Navigator.pushNamed(context, 'vendas');
                        }),
                        child: Text(
                          'Vendas',
                          style: TextStyle(
                              color: controllerNav.activeMenu.value == 'Vendas'
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    const NavSeparator(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (() {
                          controllerUsers.queryParams.clear();
                          controllerUsers.filterItemsByQuery(
                              params: controllerUsers.queryParams);
                          Navigator.pushNamed(context, 'profissionais');
                        }),
                        child: Text('Profissionais',
                            style: TextStyle(
                                color: controllerNav.activeMenu.value ==
                                        'Profissionais'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary)),
                      ),
                    ),
                    const NavSeparator(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (() {
                          controllerRedeems.queryParams.clear();
                          controllerRedeems.filterItemsByQuery(
                              params: controllerUsers.queryParams);
                          Navigator.pushNamed(context, 'resgates');
                        }),
                        child: Text('Resgates',
                            style: TextStyle(
                                color: controllerNav.activeMenu.value ==
                                        'Resgates'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary)),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const NavFeatured(),
                  const SizedBox(
                    width: 30,
                  ),
                  Obx(() {
                    controllerNav.getBrand();
                    return controllerNav.brand.value.isNotEmpty
                        ? Image.network(
                            controllerNav.brand.value,
                            width: 120,
                            height: 50,
                            fit: BoxFit.contain,
                          )
                        : const SizedBox();
                  }),
                  const SizedBox(
                    width: 30,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          const storage = FlutterSecureStorage();
                          storage.deleteAll();
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Sair'),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavSeparator extends StatelessWidget {
  const NavSeparator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      margin: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(200),
        ),
      ),
    );
  }
}
