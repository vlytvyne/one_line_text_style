import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';

class CodeGenerator {

  final Map<String, dynamic> config;

  CodeGenerator(this.config);

  String generate() {
    return _assembleDartCode([
      _getSizeBuilder(config['size']),
      _getWeightBuilder(config['weight']),
      _getColorBuilder(config['color']),
      _getFontFamilyBuilder(config['font_family']),
      _getStyleBuilder(config['style']),
      _getDecorationBuilder(config['decoration']),
      _getDecorationStyleBuilder(config['decoration_style']),
      _getOverflowBuilder(config['overflow']),
    ]);
  }

  TextStyleExtensionBuilder _getSizeBuilder(Map<String, dynamic>? sizeConfig) {
    String prefix;
    List<String> values;
    Map<String, String> customValues = {};
    bool applyPrefixToCustomValues;

    prefix = sizeConfig?['prefix'] ?? 'size';
    if (prefix.isEmpty) {
      prefix = 'size';
    }

    final int minSize = sizeConfig?['min'] ?? 8;
    final int maxSize = sizeConfig?['max'] ?? 56;
    final int step = sizeConfig?['step'] ?? 2;

    values = List.generate(
      (maxSize - minSize) ~/ step + 1,
      (index) => (minSize + index * step).toString()
    ).toList();

    customValues.addAll(_convertToStringMap(sizeConfig?['custom_values']));

    applyPrefixToCustomValues =
        sizeConfig?['apply_prefix_to_custom_values'] as bool? ?? true;

    return TextStyleExtensionBuilder(
      name: 'SizeExtension',
      prefix: prefix,
      values: values,
      mapper: (value) => Code('copyWith(fontSize: $value,)'),
      customValues: customValues,
      applyPrefixToCustomValues: applyPrefixToCustomValues,
    );
  }

  TextStyleExtensionBuilder _getColorBuilder(Map<String, dynamic>? colorConfig) {
    String? prefix;
    Map<String, String> customValues = {};

    prefix = colorConfig?['prefix'];

    customValues.addAll({
      'white': '0xFFFFFFFF',
      'black': '0xFF000000',
      'grey': '0xFF9E9E9E',
      'red': '0xFFF44336',
    });
    customValues.addAll(_convertToStringMap(colorConfig?['custom_values']));

    return TextStyleExtensionBuilder(
      name: 'ColorExtension',
      prefix: prefix,
      mapper: (value) {
        String color = value;
        if (value.startsWith('#')) {
          color = value.replaceAll('#', '0xFF');
        }
        return Code('copyWith(color: const Color($color),)');
      },
      customValues: customValues,
    );
  }

  TextStyleExtensionBuilder _getWeightBuilder(Map<String, dynamic>? weightConfig) {
    String prefix;
    List<String> values = ['100', '200', '300', '400', '500', '600', '700', '800', '900'];
    Map<String, String> customValues = {};
    bool applyPrefixToCustomValues;

    prefix = weightConfig?['prefix'] ?? 'w';
    if (prefix.isEmpty) {
      prefix = 'w';
    }

    customValues.addAll({
      'semibold': '600',
      'bold': '700',
    });
    customValues.addAll(_convertToStringMap(weightConfig?['custom_values']));

    applyPrefixToCustomValues =
        weightConfig?['apply_prefix_to_custom_values'] as bool? ?? true;

    return TextStyleExtensionBuilder(
      name: 'WeightExtension',
      prefix: prefix,
      values: values,
      mapper: (value) => Code('copyWith(fontWeight: FontWeight.w$value,)'),
      customValues: customValues,
      applyPrefixToCustomValues: applyPrefixToCustomValues,
    );

  }

  TextStyleExtensionBuilder _getFontFamilyBuilder(Map<String, dynamic>? fontFamilyConfig) {
    String? prefix = fontFamilyConfig?['prefix'];
    Map<String, String>? customValues = _convertToStringMap(fontFamilyConfig?['custom_values']);

    return TextStyleExtensionBuilder(
      name: 'FontFamilyExtension',
      prefix: prefix,
      mapper: (value) => Code('copyWith(fontFamily: $value,)'),
      customValues: customValues,
    );
  }

  TextStyleExtensionBuilder _getStyleBuilder(Map<String, dynamic>? styleConfig) {
    String? prefix = styleConfig?['prefix'];

    return TextStyleExtensionBuilder(
      name: 'StyleExtension',
      prefix: prefix,
      values: ['italic',],
      mapper: (value) => Code('copyWith(fontStyle: FontStyle.$value,)'),
    );
  }

  TextStyleExtensionBuilder _getDecorationBuilder(Map<String, dynamic>? decorationConfig) {
    String? prefix = decorationConfig?['prefix'];

    return TextStyleExtensionBuilder(
      name: 'DecorationExtension',
      prefix: prefix,
      values: ['underline', 'overline', 'lineThrough',],
      mapper: (value) => Code('copyWith(decoration: TextDecoration.$value,)'),
    );
  }

  TextStyleExtensionBuilder _getDecorationStyleBuilder(Map<String, dynamic>? decorationStyleConfig) {
    String? prefix = decorationStyleConfig?['prefix'];

    return TextStyleExtensionBuilder(
      name: 'DecorationStyleExtension',
      prefix: prefix,
      values: ['solid', 'double', 'dotted', 'dashed', 'wavy'],
      mapper: (value) => Code('copyWith(decorationStyle: TextDecorationStyle.$value,)'),
    );
  }

  TextStyleExtensionBuilder _getOverflowBuilder(Map<String, dynamic>? overflowConfig) {
    String prefix = overflowConfig?['prefix'] ?? 'overflow';

    return TextStyleExtensionBuilder(
      name: 'OverflowExtension',
      prefix: prefix,
      values: ['clip', 'fade', 'ellipsis', 'visible'],
      mapper: (value) => Code('copyWith(overflow: TextOverflow.$value,)'),
    );
  }

  Map<String, String> _convertToStringMap(Map<String, dynamic>? dataMap) {
    if (dataMap == null) {
      return {};
    }
    return Map.fromEntries(dataMap.entries.map((e) => MapEntry(e.key, e.value.toString())));
  }

  String _assembleDartCode(List<TextStyleExtensionBuilder> builders) {
    final emitter = DartEmitter();

    final rawDartCodeChunks = builders.map((builder) =>
      builder.build().accept(emitter).toString(),
    ).toList();

    final importDirective = Directive.import('package:flutter/material.dart');
    rawDartCodeChunks.insert(0, importDirective.accept(emitter).toString());

    final rawDartCode = rawDartCodeChunks.reduce((acc, next) => '$acc\n$next');
    return _formatDartCode(rawDartCode);
  }

  String _formatDartCode(String code) {
    return DartFormatter().format(code)
      .replaceAll('        ', '    ')
      .replaceAll('      ', '  ')
      .replaceAll(');', ');\n')
      .replaceAll('on TextStyle {', 'on TextStyle {\n');
  }

}