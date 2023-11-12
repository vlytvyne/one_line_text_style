import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';
import 'package:one_line_text_style/src/text_style_extention_builder_factory.dart';

class CodeGenerator {

  final TextStyleExtensionBuilderFactory factory;

  CodeGenerator(this.factory);

  String generate() {
    return _assembleDartCode([
      factory.size,
      factory.weight,
      factory.color,
      factory.fontFamily,
      factory.style,
      factory.decoration,
      factory.decorationStyle,
      factory.overflow,
    ]);
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