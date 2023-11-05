import 'package:flutter/cupertino.dart';
import 'package:minha_loja_eixo/components/forms/models/model_input.dart';

List<MInput> historyInputs = [
  MInput(
      name: 'customer_id',
      type: TextInputType.multiline,
      placeholder: 'Histórico',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo Obrigatório';
        }
        return null;
      }),
];
