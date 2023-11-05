import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/models/model_user.dart';
import 'package:minha_loja_eixo/components/forms/controllers/get.dart';
import 'package:minha_loja_eixo/components/forms/models/model_input.dart';

class BaseAutocomplete extends StatefulWidget {
  const BaseAutocomplete({
    required this.inputProps,
    required this.formData,
    super.key,
  });

  final MInput inputProps;
  final Map<String, dynamic> formData;

  @override
  State<BaseAutocomplete> createState() => _BaseAutocompleteState();
}

class _BaseAutocompleteState extends State<BaseAutocomplete> {
  static final List<User> _kOptions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUsers();
    });
  }

  _getUsers() async {
    _kOptions.removeRange(0, _kOptions.length);
    final usersList =
        await get(apiRoute: widget.inputProps.autocompleteAPIRoute);

    if (usersList.statusCode == 200) {
      for (Map<String, dynamic> user in jsonDecode(usersList.body)) {
        _kOptions.add(User.fromJson(user));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Autocomplete<User>(
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) =>
                TextFormField(
          validator: widget.inputProps.validator,
          onSaved: (value) {
            textEditingController.text = '';
          },
          focusNode: focusNode,
          controller: textEditingController,
          decoration: InputDecoration(
            label: Text(widget.inputProps.placeholder ?? ''),
          ),
        ),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable.empty();
          }
          return _kOptions.where((User option) {
            return option.firstName
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()) ||
                option.cpf == textEditingValue.text;
          });
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Material(
            child: SizedBox(
              height: 52.0 * options.length,
              width: 100,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    final User option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () => onSelected(option),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: option.avatarUrl != null
                                    ? Image.network(
                                        option.avatarUrl!,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      )
                                    : Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(option.toString()),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        },
        onSelected: (User selection) {
          setState(() {
            widget.formData[widget.inputProps.name] = selection.id.toString();
          });
        },
      ),
    );
  }
}
