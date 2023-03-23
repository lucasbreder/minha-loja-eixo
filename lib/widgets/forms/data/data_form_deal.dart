import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:minha_loja_eixo/widgets/forms/models/model_input.dart';

List<MInput> dealInputs = [
  MInput(
      name: 'customer_id',
      type: TextInputType.text,
      placeholder: 'Profissional',
      category: MInputCategories.autocomplete,
      autocompleteAPIRoute: 'https://api.eixo.site/allUsers/',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo Obrigatório';
        }
        return null;
      }),
  MInput(
    name: 'value',
    type: TextInputType.number,
    placeholder: 'Valor',
    category: MInputCategories.currency,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Campo Obrigatório';
      } else if (double.parse(toCurrencyString(value,
              thousandSeparator: ThousandSeparator.None)) <=
          0) {
        return 'Valor inválido';
      }
      return null;
    },
    mask: [
      CurrencyInputFormatter(
        useSymbolPadding: true,
        thousandSeparator: ThousandSeparator.Period,
        leadingSymbol: 'R\$',
      )
    ],
  ),
  const MInput(
    name: 'description',
    type: TextInputType.multiline,
    placeholder: 'Descrição',
  ),
  const MInput(
    name: 'is_shared',
    category: MInputCategories.radio,
    label: 'Compartilhar os dados dessa venda com outros lojistas?',
  ),
];
