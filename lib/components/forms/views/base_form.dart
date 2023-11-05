import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/components/buttons/views/view_button_general.dart';
import 'package:minha_loja_eixo/components/forms/controllers/post.dart';
import 'package:minha_loja_eixo/components/forms/models/model_errors_api.dart';
import 'package:minha_loja_eixo/components/forms/models/model_input.dart';
import 'package:minha_loja_eixo/components/forms/views/base_input.dart';
import 'package:minha_loja_eixo/components/forms/views/base_autocomplete.dart';
import 'package:minha_loja_eixo/components/forms/views/base_check.dart';
import 'package:minha_loja_eixo/services/controller_deals.dart';

class BaseForm extends StatefulWidget {
  const BaseForm({
    required this.formInputs,
    this.submitText = 'Enviar',
    this.redirectRoute,
    this.successMessage,
    this.formTheme,
    this.controller,
    this.isLogin = false,
    required this.apiRoute,
    super.key,
  });

  final List<MInput> formInputs;
  final String submitText;
  final String? formTheme;
  final String apiRoute;
  final String? redirectRoute;
  final String? successMessage;
  final dynamic controller;
  final bool isLogin;

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  Map<String, String> formData = {};
  String formReturn = '';
  List<MessageReturn> validationMessages = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    for (MInput input in widget.formInputs) {
      formData[input.name] = input.value ?? '';
    }
    super.initState();
  }

  inputSwitch(MInput inputItemProps) {
    switch (inputItemProps.category) {
      case MInputCategories.autocomplete:
        return BaseAutocomplete(
          inputProps: inputItemProps,
          formData: formData,
        );
      case MInputCategories.radio:
        return BaseCheck(
          inputProps: inputItemProps,
          formData: formData,
        );
      case MInputCategories.hiddenCheck:
        return BaseCheck(
          inputProps: inputItemProps,
          formData: formData,
        );
      default:
        return BaseInput(
          inputProps: inputItemProps,
          formData: formData,
          formTheme: widget.formTheme,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            formReturn,
            style: TextStyle(
              fontSize: 18.0,
              color: widget.formTheme == 'light'
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              for (MInput input in widget.formInputs) inputSwitch(input),
            ],
          ),
        ),
        ButtonGeneral(
          text: 'Enviar',
          themeButton: widget.formTheme == 'light' ? 'light' : '',
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              setState(() {
                formReturn = 'Enviando...';
              });
              try {
                final formResult = await post(
                  data: formData,
                  apiRoute: widget.apiRoute,
                  redirectRoute: widget.redirectRoute,
                  context: context,
                  successMessage: widget.successMessage,
                  isLogin: widget.isLogin,
                );
                if (formResult.statusCode ~/ 100 == 2) {
                  _formKey.currentState!.save();
                  setState(() {
                    formReturn = 'Salvo com Sucesso';
                  });
                  if (widget.controller != null) {
                    widget.controller!.loadAllItems();
                  }
                } else if (formResult.statusCode ~/ 100 == 4) {
                  ErrorsApi dataErrors =
                      ErrorsApi.fromJson(jsonDecode(formResult.body));

                  setState(() {
                    formReturn = dataErrors.errors
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", "");
                  });
                }
              } on TimeoutException {
                formReturn =
                    'Sua solicitação está demorando demais, tente novamente';
              } on Exception {
                formReturn = 'Houve um erro no envio do formulário';
              }
            }
          },
        )
      ],
    );
  }
}
