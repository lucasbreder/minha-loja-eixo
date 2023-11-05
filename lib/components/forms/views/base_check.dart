import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/components/forms/models/model_input.dart';

class BaseCheck extends StatefulWidget {
  const BaseCheck({
    required this.inputProps,
    required this.formData,
    super.key,
  });

  final MInput inputProps;
  final Map<String, String> formData;

  @override
  State<BaseCheck> createState() => _BaseCheckState();
}

class _BaseCheckState extends State<BaseCheck> {
  @override
  void initState() {
    widget.formData[widget.inputProps.name] =
        widget.inputProps.value ?? 'false';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.inputProps.category == MInputCategories.hiddenCheck
          ? false
          : true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        child: CheckboxListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(widget.inputProps.label ?? ''),
          value:
              widget.formData[widget.inputProps.name] == 'true' ? true : false,
          checkboxShape: const CircleBorder(),
          controlAffinity: ListTileControlAffinity.leading,
          enabled: widget.inputProps.category == MInputCategories.hiddenCheck
              ? false
              : true,
          onChanged: (value) {
            setState(() {
              widget.formData[widget.inputProps.name] = value.toString();
            });
          },
        ),
      ),
    );
  }
}
