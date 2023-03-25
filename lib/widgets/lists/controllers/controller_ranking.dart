import 'dart:convert';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/widgets/forms/controllers/get.dart';
import 'package:minha_loja_eixo/widgets/forms/models/response_api.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_pagination_info.dart';

class ControllerUsersRanking extends GetxController {
  // this is the list of items
  RxList<dynamic> itemsList = [].obs;
  Rx<PaginationInfo> pagesInfo = PaginationInfo().obs;
  RxBool isLoading = false.obs;
  RxMap<dynamic, dynamic> queryParams = {}.obs;

  @override
  void onInit() async {
    await filterItemsByQuery(
        params: {'orderBy': 'accounts.balance', 'sort': 'desc'});
  }

  loadAllItems({int? page = 1}) async {
    itemsList.assignAll([]);
    isLoading.value = true;
    var databaseResponse =
        await get(apiRoute: 'https://api.eixo.site/users/?page=$page');

    if (databaseResponse.statusCode == 200) {
      DataResponse dataResponse =
          DataResponse.fromJson(jsonDecode(databaseResponse.body));
      itemsList.assignAll(dataResponse.data);

      PaginationInfo paginationInfo =
          PaginationInfo.fromJson(dataResponse.meta);
      pagesInfo.value = paginationInfo;
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
        await get(apiRoute: 'https://api.eixo.site/users/?$query');

    if (databaseResponse.statusCode == 200) {
      DataResponse dataResponse =
          DataResponse.fromJson(jsonDecode(databaseResponse.body));
      itemsList.assignAll(dataResponse.data);

      PaginationInfo paginationInfo =
          PaginationInfo.fromJson(dataResponse.meta);
      pagesInfo.value = paginationInfo;
    } else {
      itemsList.assignAll([]);
    }
    isLoading.value = false;
  }

  removeAllItems() {
    itemsList.assignAll([]);
  }
}
