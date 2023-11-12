import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:one_line_text_style/src/default_extention_builders.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';

class CodeGenerator {

  final Map<String, dynamic> config;

  CodeGenerator(this.config);

  String generate() {
    _applyConfig();

    return _assembleDartCode([
      extensionSizeBuilder,
      // extensionWeightBuilder,
      extensionColorBuilder,
      // extensionStyleBuilder,
      // extensionDecorationBuilder,
      // extensionDecorationStyleBuilder,
      // extensionFontFamilyBuilder,
      // extensionOverflowBuilder,
    ]);
  }

  void _applyConfig() {
    final sizeMap = config['size'] as Map?;
    if (sizeMap != null) {
      if (sizeMap['prefix'] != null && (sizeMap['prefix'] as String).isNotEmpty) {
        extensionSizeBuilder.prefix = sizeMap['prefix'];
      }

      int minSize = sizeMap['min'] ?? 8;
      int maxSize = sizeMap['max'] ?? 56;
      int step = sizeMap['step'] ?? 2;

      extensionSizeBuilder.values = List.generate((maxSize - minSize) ~/ step + 1, (index) => (minSize + index * step)).map((e) => e.toString()).toList();

      if (sizeMap['custom_values'] != null) {
        final customValues = _convertToStringMap(sizeMap['custom_values']);
        if (extensionSizeBuilder.customValues == null) {
          extensionSizeBuilder.customValues = customValues;
        } else {
          extensionSizeBuilder.customValues!.addAll(customValues);
        }
      }

      if (sizeMap['apply_prefix_to_custom_values'] != null) {
        extensionSizeBuilder.applyPrefixToCustomValues = sizeMap['apply_prefix_to_custom_values'] as bool;
      }
    }
  }

  Map<String, String> _convertToStringMap(Map<String, dynamic> dataMap) {
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