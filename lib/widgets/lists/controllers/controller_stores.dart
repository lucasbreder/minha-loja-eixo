import 'dart:convert';

import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/forms/controllers/get.dart';

class ControllerStores extends GetxController {
  // this is the list of items
  RxList<dynamic> itemsList = [].obs;

  @override
  void onInit() async {
    await loadAllItems();
  }

  loadAllItems() async {
    var databaseResponse = await get(apiRoute: 'https://api.eixo.site/stores');

    if (databaseResponse.statusCode == 200) {
      Iterable data = jsonDecode(databaseResponse.body);
      itemsList.assignAll(data);
    } else {
      itemsList.assignAll([]);
    }
  }
}
