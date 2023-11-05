import 'dart:convert';

import 'package:minha_loja_eixo/components/forms/models/model_errors_api.dart';
import 'package:minha_loja_eixo/components/forms/models/response_api.dart';

MResponsePaginationAPI responseAPI({
  required int statusCode,
  String? responseData,
  String? successMessage,
}) {
  String message = '';
  dynamic returnListMessagesApi;
  dynamic returnMessageApi;

  final dynamic response =
      responseData != null ? json.decode(responseData) : '';

  if (response is Map) {
    returnListMessagesApi =
        response.containsKey('errors') ? ErrorsApi.fromJson(response) : null;

    returnMessageApi = response.containsKey('message')
        ? MessageReturn(
            message: response['message'],
            field: response['field'],
          )
        : null;
  }

  // final returnApi = response.contains ErrorsApi.fromJson(errorsList);

  if (returnListMessagesApi != null) {
    message = returnListMessagesApi.errors.toString();
  } else if (returnMessageApi != null) {
    message = returnMessageApi.message;
  } else if (statusCode >= 200 && statusCode <= 299) {
    message = successMessage ?? "Enviado com Sucesso";
  } else {
    message = "Houve um erro";
  }

  return MResponsePaginationAPI(
    message: message,
    body: response,
    erros: returnListMessagesApi?.errors,
    statusCode: statusCode,
  );
}
