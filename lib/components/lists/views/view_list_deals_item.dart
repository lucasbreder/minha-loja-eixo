import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/screens/page_user.dart';
import 'package:minha_loja_eixo/components/forms/controllers/post.dart';
import 'package:minha_loja_eixo/services/controller_deals.dart';
import 'package:minha_loja_eixo/models/model_deal.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja_eixo/models/model_store.dart';
import 'package:minha_loja_eixo/models/model_user.dart';
import 'package:minha_loja_eixo/components/lists/views/view_confirm_deal.dart';

class ListDealsItem extends StatelessWidget {
  const ListDealsItem({required this.data, super.key});

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
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "#${dealData.id.toString()}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            const Separator(),
                            Text(
                              store != null ? store.name : 'Resgate',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Container(
                                  width: 3,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              formatterDate.format(dealDate),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              controller.queryParams
                                  .addAll({'userId': customer.id});
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
                            child: Text(
                              "${customer.firstName.trim()} ${customer.lastName.trim()}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                dealData.description != null
                    ? Text(dealData.description!)
                    : const SizedBox()
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (dealData.value != null &&
                    dealData.value! > 0 &&
                    dealData.isConfirmed == false)
                  GestureDetector(
                    onTap: () async {
                      const storage = FlutterSecureStorage();
                      String? role = await storage.read(key: 'role');
                      if (role == "4") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => ConfirmDeal(
                            store: store!,
                            customer: customer,
                            deal: dealData,
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: !dealData.isConfirmed
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                Text(
                  dealData.value != null && dealData.value! > 0
                      ? formatterNumber.format(dealData.value)
                      : dealData.value! == 0
                          ? ''
                          : '${dealData.value.toString()}pts',
                  style: TextStyle(
                    color: dealData.value! > 0
                        ? Theme.of(context).colorScheme.primary
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
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
