import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:minha_loja_eixo/components/forms/models/model_input.dart';

class BaseInput extends StatefulWidget {
  const BaseInput({
    required this.inputProps,
    required this.formData,
    this.formTheme,
    super.key,
  });

  final MInput inputProps;
  final String? formTheme;
  final Map<String, dynamic> formData;

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  final _inputController = TextEditingController();

  @override
  void initState() {
    _inputController.text = widget.inputProps.value ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        showCursor: true,
        onSaved: (value) {
          _inputController.text = '';
        },
        onChanged: (value) {
          final focusPosition =
              widget.inputProps.category == MInputCategories.currency
                  ? _inputController.text.length - 3
                  : _inputController.text.length;
          _inputController.selection =
              TextSelection.fromPosition(TextPosition(offset: focusPosition));
          setState(() {
            widget.formData[widget.inputProps.name] =
                widget.inputProps.category == MInputCategories.currency
                    ? toCurrencyString(value,
                        thousandSeparator: ThousandSeparator.None)
                    : value;
          });
        },
        controller: _inputController,
        obscureText: widget.inputProps.category == MInputCategories.password,
        decoration: InputDecoration(
          label: Text(
            widget.inputProps.placeholder ?? '',
            style: TextStyle(
              color: widget.formTheme == 'light'
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: widget.formTheme == 'light'
                    ? Colors.white
                    : Theme.of(context).colorScheme.tertiary,
                width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: widget.formTheme == 'light'
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                width: 1),
          ),
          focusColor: widget.formTheme == 'light'
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
        ),
        validator: widget.inputProps.validator,
        keyboardType: widget.inputProps.type,
        inputFormatters: widget.inputProps.mask,
        style: TextStyle(
          color: widget.formTheme == 'light'
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
