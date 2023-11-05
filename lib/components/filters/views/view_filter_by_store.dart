import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/services/controller_deals.dart';
import 'package:minha_loja_eixo/services/controller_stores.dart';
import 'package:minha_loja_eixo/models/model_store.dart';

class ListFilterByStore extends StatefulWidget {
  const ListFilterByStore({super.key});

  @override
  State<ListFilterByStore> createState() => _ListFilterByStoreState();
}

class _ListFilterByStoreState extends State<ListFilterByStore> {
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    ControllerStores controller = Get.put(ControllerStores());
    ControllerDeals controllerDeals = Get.put(ControllerDeals());

    List<DropdownMenuItem<Object>>? dropDowItems() {
      List<DropdownMenuItem<Object>>? items = [];

      items.add(
        const DropdownMenuItem<String>(
          value: "0",
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Selecione",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );

      for (Map<String, dynamic> storeData in controller.itemsList) {
        Store store = Store.fromJson(storeData);
        items.add(
          DropdownMenuItem<String>(
            value: store.id.toString(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                store.name,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      }
      return items;
    }

    return Obx((() => Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Lojas:",
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              width: 30,
            ),
            DropdownButton(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              alignment: AlignmentDirectional.center,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Bahnschrift',
              ),
              onChanged: (value) async {
                int id = int.parse(value.toString());

                if (id != 0) {
                  controllerDeals.queryParams
                      .addAll({'storeId': id, 'page': 1});
                  await controllerDeals.filterItemsByQuery(
                      params: controllerDeals.queryParams);
                } else {
                  controllerDeals.queryParams.remove('storeId');
                  controllerDeals.loadAllItems();
                }

                setState(() {
                  dropdownValue = id.toString();
                });
              },
              value: dropdownValue != '' ? dropdownValue : "0",
              items: dropDowItems(),
            ),
          ],
        )));
  }
}
