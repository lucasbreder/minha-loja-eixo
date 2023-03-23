import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:minha_loja_eixo/widgets/forms/controllers/post.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_deal.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_store.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_user.dart';

class ConfirmDeal extends StatefulWidget {
  const ConfirmDeal(
      {required this.store,
      required this.customer,
      required this.deal,
      super.key});

  final Store store;
  final User customer;
  final Deal deal;

  @override
  State<ConfirmDeal> createState() => _ConfirmDealState();
}

class _ConfirmDealState extends State<ConfirmDeal> {
  String modalReturn = '';
  ControllerDeals controller = Get.put(ControllerDeals());

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatterNumber =
        NumberFormat.currency(locale: "pt_BR", symbol: 'R\$');

    return AlertDialog(
      title: Text(
        "Quer confirmar essa venda?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontFamily: 'Bahnschrift',
          fontSize: 18,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      actionsAlignment: MainAxisAlignment.center,
      content: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          widget.store.brand != null
              ? Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                  child: Image.network(
                    widget.store.brand!,
                    width: 200,
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Valor ${formatterNumber.format(widget.deal.value)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Venda para ',
              ),
              Text(
                '${widget.customer.firstName.trim()} ${widget.customer.lastName.trim()}',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          modalReturn != ''
              ? Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary,
                  )),
                  child: Text(
                    modalReturn,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
      actions: [
        modalReturn == ''
            ? Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (modalReturn == '') {
                      final confirmDeal = await post(
                        data: {"deal_id": widget.deal.id.toString()},
                        apiRoute: "https://api.eixo.site/confirmDeal",
                      );
                      if (confirmDeal.statusCode ~/ 100 == 2) {
                        setState(() {
                          modalReturn = "Confirmada com Sucesso";
                        });
                        controller.loadAllItems();
                      } else {
                        setState(() {
                          modalReturn =
                              "Houve um erro na confirmação, tente novamente mais tarde";
                        });
                      }
                    }
                  },
                  child: Text(
                    'Sim',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              )
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(80)),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              modalReturn == '' ? 'Não' : 'Fechar',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}
