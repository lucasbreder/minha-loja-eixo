import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/pages/page_user.dart';
import 'package:minha_loja_eixo/widgets/dashboard/views/dashboard_deals_chart.dart';
import 'package:minha_loja_eixo/widgets/details/views/detail_profile_social_link.dart';
import 'package:minha_loja_eixo/widgets/details/views/detail_profile_user.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_user.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_deals.dart';

class DetailUser extends StatelessWidget {
  const DetailUser({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    User userData = User.fromJson(data);
    ControllerDeals controller = Get.put(ControllerDeals());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(400)),
              child: userData.avatarUrl != null
                  ? Image.network(
                      userData.avatarUrl!,
                      width: 220,
                      height: 220,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    )
                  : Image.asset(
                      'assets/images/profile.jpg',
                      width: 220,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${userData.id.toString()}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: Text(
                    '${userData.firstName} ${userData.lastName}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  userData.profession ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              userData.balance != null
                  ? '${userData.balance!.toInt().toString()}pts'
                  : '',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 40.0),
              padding: const EdgeInsets.only(left: 40.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailProfileUser(
                    title: 'Endereço',
                    text: userData.address!,
                  ),
                  DetailProfileUser(
                    title: 'Data de Nascimento',
                    text: userData.birthDate!,
                  ),
                  DetailProfileUser(
                    title: 'Telefone',
                    text: userData.phone!,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailProfileSocial(
                        title: 'Instagram',
                        user: userData.instagramUser,
                      ),
                      DetailProfileSocial(
                        title: 'Facebook',
                        user: userData.facebookUser,
                      ),
                      DetailProfileSocial(
                        showSeparator: false,
                        title: 'LinkedIn',
                        user: userData.linkedInUser,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 1,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Text(
          'Histórico de Vendas e Resgates',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const ListDeals(
          showTotal: false,
        ),
        const SizedBox(
          height: 40,
        ),
        const DashboardDealsChart(),
      ],
    );
  }
}
