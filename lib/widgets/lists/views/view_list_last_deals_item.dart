import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/pages/page_user.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_deal.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_store.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_user.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_confirm_deal.dart';

class ListLastDealsItem extends StatelessWidget {
  const ListLastDealsItem(
      {required this.data, this.noConfimed = false, super.key});

  final bool noConfimed;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());
    final dealData = Deal.fromJson(data);
    final store = dealData.store != null && dealData.store!.isNotEmpty
        ? Store.fromJson(dealData.store!)
        : null;
    final customer = User.fromJson(dealData.customer);
    final DateFormat formatterDate = DateFormat('dd/MM/yyyy');
    final NumberFormat formatterNumber =
        NumberFormat.currency(locale: "pt_BR", symbol: 'R\$');
    final dealDate = DateTime.parse(dealData.createdAt);

    return Container(
      width: 418,
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Text(
                formatterDate.format(dealDate),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 418,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      controller.queryParams.addAll({'userId': customer.id});
                      controller.filterItemsByQuery(
                          params: controller.queryParams);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageUser(
                                  userId: customer.id,
                                )),
                      );
                    },
                    child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width < 900 ? 120 : 300,
                      child: Text(
                        "${customer.firstName.trim()} ${customer.lastName.trim()}",
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
                  dealData.value != null && dealData.value! > 0
                      ? formatterNumber.format(
                          noConfimed ? dealData.value! * 0.01 : dealData.value)
                      : dealData.value! == 0
                          ? ''
                          : '${dealData.value.toString()}pts',
                  style: TextStyle(
                    color: !noConfimed
                        ? Theme.of(context).colorScheme.primary
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
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
