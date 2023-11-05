class ErrorsApi {
  final List<MessageReturn> errors;

  const ErrorsApi({
    required this.errors,
  });

  factory ErrorsApi.fromJson(dynamic json) {
    List<MessageReturn> errors = [];

    for (dynamic error in json['errors']) {
      final errorItem = MessageReturn(
        field: error['field'] ?? '',
        message: error['message'] ?? '',
      );
      errors.add(errorItem);
    }
    return ErrorsApi(
      errors: errors,
    );
  }
}

class MessageReturn {
  final String message;
  final String? field;

  const MessageReturn({
    required this.message,
    this.field,
  });

  @override
  String toString() {
    return field != null && field!.isNotEmpty
        ? '$field - $message '
        : '$message ';
  }
}
