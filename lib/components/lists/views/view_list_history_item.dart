import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/screens/page_user.dart';
import 'package:minha_loja_eixo/services/controller_deals.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja_eixo/models/model_prize.dart';
import 'package:minha_loja_eixo/models/model_redeem.dart';
import 'package:minha_loja_eixo/models/model_user.dart';

class ListHistoryItem extends StatelessWidget {
  const ListHistoryItem(
      {required this.data, this.noConfimed = false, super.key});

  final bool noConfimed;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());
    final redeemData = Redeem.fromJson(data);
    final user = User.fromJson(redeemData.user);
    final prize = Prize.fromJson(redeemData.prize);
    final DateFormat formatterDate = DateFormat('dd/MM/yyyy');
    final dealDate = DateTime.parse(redeemData.createdAt);

    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Theme.of(context).colorScheme.tertiary,
        width: 1,
      ))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatterDate.format(dealDate),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    controller.queryParams.addAll({'userId': user.id});
                    controller.filterItemsByQuery(
                        params: controller.queryParams);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageUser(
                                userId: user.id,
                              )),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width < 900 ? 240 : 350,
                    child: Text(
                      "${user.firstName.trim()} ${user.lastName.trim()} - ${prize.name}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 61, 61, 61),
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                '${redeemData.score.toString()}pts',
                style: TextStyle(
                  color: !noConfimed
                      ? Theme.of(context).colorScheme.primary
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
