import 'dart:convert';

import 'package:get/get.dart';
import 'package:minha_loja_eixo/components/forms/controllers/get.dart';
import 'package:minha_loja_eixo/components/forms/models/response_api.dart';
import 'package:minha_loja_eixo/models/model_pagination_info.dart';
import 'package:minha_loja_eixo/models/model_totals_info.dart';

class ControllerDeals extends GetxController {
  // this is the list of items
  RxList<dynamic> itemsList = [].obs;
  Rx<PaginationInfo> pagesInfo = PaginationInfo().obs;
  Rx<DealsTotalsInfo> totalsInfo = DealsTotalsInfo().obs;
  RxBool isLoading = false.obs;
  RxMap<dynamic, dynamic> queryParams = {}.obs;

  @override
  void onInit() async {
    await loadAllItems();
  }

  loadAllItems({int? page = 1}) async {
    itemsList.assignAll([]);
    isLoading.value = true;
    var databaseResponse =
        await get(apiRoute: 'https://api.eixo.site/myStoreDeals/?page=$page');

    if (databaseResponse.statusCode == 200) {
      DataResponseDeals dataResponse =
          DataResponseDeals.fromJson(jsonDecode(databaseResponse.body));
      itemsList.assignAll(dataResponse.data);

      PaginationInfo paginationInfo =
          PaginationInfo.fromJson(dataResponse.meta);
      pagesInfo.value = paginationInfo;

      DealsTotalsInfo dealsTotalsInfo =
          DealsTotalsInfo.fromJson(dataResponse.totals);
      totalsInfo.value = dealsTotalsInfo;
    } else {
      itemsList.assignAll([]);
    }
    isLoading.value = false;
  }

  filterItemsByQuery({required Map<dynamic, dynamic> params}) async {
    itemsList.assignAll([]);
    isLoading.value = true;

    var query = "";

    for (var key in params.keys) {
      query += '&$key=${params[key]}';
    }
    var databaseResponse =
        await get(apiRoute: 'https://api.eixo.site/myStoreDeals/?$query');

    if (databaseResponse.statusCode == 200) {
      DataResponseDeals dataResponse =
          DataResponseDeals.fromJson(jsonDecode(databaseResponse.body));
      itemsList.assignAll(dataResponse.data);

      PaginationInfo paginationInfo =
          PaginationInfo.fromJson(dataResponse.meta);
      pagesInfo.value = paginationInfo;

      DealsTotalsInfo dealsTotalsInfo =
          DealsTotalsInfo.fromJson(dataResponse.totals);
      totalsInfo.value = dealsTotalsInfo;
    } else {
      itemsList.assignAll([]);
    }
    isLoading.value = false;
  }

  removeAllItems() {
    itemsList.assignAll([]);
  }
}
