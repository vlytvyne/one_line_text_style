import 'package:code_builder/code_builder.dart';

class TextStyleExtensionBuilder {

  final String name;
  final Code Function(String value) mapper;
  final List<String>? values;
  final String? prefix;
  final Map<String, String>? customValues;
  final bool applyPrefixToCustomValues;

  TextStyleExtensionBuilder({
    required this.name,
    required this.mapper,
    this.values,
    this.prefix,
    this.customValues,
    this.applyPrefixToCustomValues = true,
  });

  Extension build() {
    final getters = (values ?? []).map((value) => _buildGetter(value: value),).toList();

    if (customValues != null) {
      final customGetters = customValues!.keys.map((key) =>
          _buildGetter(value: customValues![key]!, customName: key)
      );
      getters.addAll(customGetters);
    }

    return Extension((b) => b
      ..name = name
      ..on = refer('TextStyle')
      ..methods.addAll(getters),
    );
  }

  Method _buildGetter({
    required String value,
    String? customName,
  }) {
    String formattedName = _getFormattedGetterName(
        value: value,
        customName: customName
    );

    return Method((m) => m
      ..name = formattedName
      ..type = MethodType.getter
      ..returns = refer('TextStyle')
      ..lambda = true
      ..body = mapper(value),
    );
  }

  String _getFormattedGetterName({
    required String value,
    String? customName,
  }) {
    if (customName != null) {

      if (applyPrefixToCustomValues) {

        if (prefix != null && prefix!.isNotEmpty) {
          return prefix! + _capitalize(customName);
        } else {
          return customName;
        }

      } else {
        return customName;
      }

    } else {

      if (prefix != null && prefix!.isNotEmpty) {
        return prefix! + _capitalize(value);
      } else {
        return value;
      }

    }
  }

  String _capitalize(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

}
