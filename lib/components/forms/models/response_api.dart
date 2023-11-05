import 'package:minha_loja_eixo/components/forms/models/model_errors_api.dart';

class MResponsePaginationAPI {
  final String message;
  final Iterable<dynamic> body;
  final List<MessageReturn>? erros;
  final int statusCode;

  const MResponsePaginationAPI({
    required this.message,
    required this.body,
    this.erros,
    required this.statusCode,
  });
}

class DataResponse {
  final Map<String, dynamic> meta;
  final Iterable<dynamic> data;

  const DataResponse({
    required this.meta,
    required this.data,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(data: json['data'], meta: json['meta']);
  }
}

class DataResponseDeals {
  final Map<String, dynamic> totals;
  final Map<String, dynamic> meta;
  final Iterable<dynamic> data;

  const DataResponseDeals({
    required this.totals,
    required this.meta,
    required this.data,
  });

  factory DataResponseDeals.fromJson(Map<String, dynamic> json) {
    return DataResponseDeals(
        data: json['data'], meta: json['meta'], totals: json['totals']);
  }
}

class MResponseAPI {
  final String message;
  final DataResponse body;
  final List<MessageReturn>? erros;
  final int statusCode;

  const MResponseAPI({
    required this.message,
    required this.body,
    this.erros,
    required this.statusCode,
  });
}
