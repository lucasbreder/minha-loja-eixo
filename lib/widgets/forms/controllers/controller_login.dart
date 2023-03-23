import 'dart:convert';

import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/forms/controllers/get.dart';
import 'package:minha_loja_eixo/widgets/forms/models/response_api.dart';

class ControllerLogin extends GetxController {
  // this is the list of items
  RxList<dynamic> itemsList = [].obs;

  login() async {
    var databaseResponse =
        await get(apiRoute: 'https://api.eixo.site/myStoreDeals');

    if (databaseResponse.statusCode == 200) {
      DataResponse data =
          DataResponse.fromJson(jsonDecode(databaseResponse.body));
      itemsList.assignAll(data.data);
    } else {
      itemsList.assignAll([]);
    }
  }
}
