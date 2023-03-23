import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/nav/views/view_featured_nav.dart';

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());
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
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 600),
                child: Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (() {
                          controller.queryParams.clear();
                          controller.filterItemsByQuery(
                              params: controller.queryParams);
                          Navigator.pushNamed(context, 'vendas');
                        }),
                        child: const Text('Vendas'),
                      ),
                    ),
                    const NavSeparator(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(context, 'profissionais');
                        }),
                        child: const Text('Profissionais'),
                      ),
                    ),
                  ],
                ),
              ),
              const NavFeatured(),
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
