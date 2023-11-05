import 'package:minha_loja_eixo/components/forms/models/model_errors_api.dart';

String findValidator(List<MessageReturn> validationMessages, String name) {
  for (MessageReturn validatoritem in validationMessages) {
    if (validatoritem.field == name) {
      return validatoritem.message;
    }
  }
  return '';
}
