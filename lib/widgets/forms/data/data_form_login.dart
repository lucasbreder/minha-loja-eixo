import 'package:flutter/cupertino.dart';
import 'package:minha_loja_eixo/widgets/forms/models/model_input.dart';

List<MInput> loginInputs = const [
  MInput(
    name: 'email',
    type: TextInputType.emailAddress,
    placeholder: 'E-mail',
  ),
  MInput(
    name: 'password',
    type: TextInputType.text,
    category: MInputCategories.password,
    placeholder: 'Senha',
  )
];
