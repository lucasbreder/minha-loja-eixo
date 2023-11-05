import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class MInput {
  final String? label;
  final String? placeholder;
  final dynamic value;
  final TextInputType? type;
  final MInputCategories? category;
  final String? autocompleteAPIRoute;
  final String name;
  final List<TextInputFormatter>? mask;
  final String? Function(String?)? validator;

  const MInput({
    this.label,
    this.placeholder,
    this.value,
    this.mask = const [],
    this.validator,
    this.category,
    this.autocompleteAPIRoute,
    this.type = TextInputType.text,
    required this.name,
  });
}

enum MInputCategories {
  autocomplete,
  currency,
  password,
  radio,
  hiddenCheck,
}
