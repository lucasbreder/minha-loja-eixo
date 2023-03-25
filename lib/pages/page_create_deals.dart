import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_deals.dart';
import 'package:minha_loja_eixo/widgets/forms/data/data_form_deal.dart';
import 'package:minha_loja_eixo/widgets/forms/views/base_form.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_last_deals.dart';
import 'package:minha_loja_eixo/widgets/scaffold/views/base_scaffold.dart';
import 'package:minha_loja_eixo/widgets/titles/views/view_base_title.dart';
import 'package:url_launcher/url_launcher.dart';

class PageCreateDeals extends StatelessWidget {
  const PageCreateDeals({super.key});

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    bool isMobile = MediaQuery.of(context).size.width < 900;
    ControllerDeals controllerDeals = Get.put(ControllerDeals());

    return BaseScaffold(
      title: 'Cadastrar Venda',
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.spaceBetween,
          spacing: 40.0,
          children: [
            Container(
              width: isMobile ? pageWidth : 1100 / 2,
              margin: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        Uri url = Uri.parse(
                            'https://docs.google.com/forms/d/e/1FAIpQLSejqW_-l6CE73fzRlPgGOdkigrx-7vcYYuHS5mwkiGEsG1wIA/viewform?usp=sf_link');
                        await launchUrl(url, mode: LaunchMode.platformDefault);
                      },
                      child: Text(
                        'Para profissionais ainda não cadastrados, clique aqui',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  BaseForm(
                    formInputs: dealInputs,
                    apiRoute: 'https://api.eixo.site/deal',
                    controller: controllerDeals,
                  ),
                ],
              ),
            ),
            Container(
              width: isMobile ? pageWidth : 1100 / 2.5,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isMobile
                        ? Colors.white
                        : Theme.of(context).colorScheme.tertiary,
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.only(left: isMobile ? 0 : 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  BaseTitle(
                    title: 'Últimas Vendas',
                    fontSize: 30.0,
                  ),
                  ListLastDeals(
                    limit: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
