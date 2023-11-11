import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';
import 'package:args/args.dart';
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();

  parser.addOption('config-path');
  parser.addOption('result-path');

  final parsedArgs = parser.parse(args);

  final config = getConfig(parsedArgs['config-path']);
  print(config['color']['values']['red']);

  // codeBuild();
}

Map<String, dynamic> getConfig(String? configFilePath,) {
  File file;

  if (configFilePath != null) {
    if (File(configFilePath).existsSync()) {
      file = File(configFilePath);
    } else {
      print('The config file `$configFilePath` was not found.');
      exit(1);
    }
  } else if (File('one_line_text_style.yaml').existsSync()) {
    file = File('one_line_text_style.yaml');
  } else {
    file = File('pubspec.yaml');
  }

  final Map yamlMap = loadYaml(file.readAsStringSync()) as Map;

  if (yamlMap['one_line_text_style'] is! Map) {
    throw Exception(
      'Your `${file.path}` file does not contain a `one_line_text_style` section.',
    );
  }

  // yamlMap has the type YamlMap, which has several unwanted side effects
  return _yamlToMap(yamlMap['one_line_text_style'] as YamlMap);
}

Map<String, dynamic> _yamlToMap(YamlMap yamlMap) {
  final Map<String, dynamic> map = <String, dynamic>{};

  for (final MapEntry<dynamic, dynamic> entry in yamlMap.entries) {
    if (entry.value is YamlList) {
      final list = <String>[];
      for (final value in entry.value as YamlList) {
        if (value is String) {
          list.add(value);
        }
      }
      map[entry.key as String] = list;
    } else if (entry.value is YamlMap) {
      map[entry.key as String] = _yamlToMap(entry.value as YamlMap);
    } else {
      map[entry.key as String] = entry.value;
    }
  }
  return map;
}

void codeBuild() {
  final extensionSizeBuilder = TextStyleExtensionBuilder(
    name: 'SizeExtension',
    prefix: 'size',
    values: ['14', '16', '18',],
    mapper: (value) => Code('copyWith(fontSize: $value,)'),
  );

  final extensionWeightBuilder = TextStyleExtensionBuilder(
    name: 'WeightExtension',
    prefix: 'w',
    values: ['600', '700',],
    mapper: (value) => Code('copyWith(fontWeight: FontWeight.w${value},)'),
    customValues: {
      'semibold': '600',
      'bold': '700',
    },
    applyPrefixToCustomValues: false,
  );

  final extensionColorBuilder = TextStyleExtensionBuilder(
    name: 'ColorExtension',
    prefix: 'color',
    mapper: (value) => Code('copyWith(color: const Color($value),)'),
    customValues: {
      'white': '0xFFFFFFFF',
      'black': '0xFF000000',
      'grey': '0xFF9E9E9E',
      'red': '0xFFF44336',
    }
  );

  final extensionStyleBuilder = TextStyleExtensionBuilder(
    name: 'StyleExtension',
    prefix: 'style',
    values: ['italic', 'normal',],
    mapper: (value) => Code('copyWith(fontStyle: FontStyle.$value,)'),
  );

  final extensionDecorationBuilder = TextStyleExtensionBuilder(
    name: 'DecorationExtension',
    values: ['underline', 'overline', 'lineThrough',],
    mapper: (value) => Code('copyWith(decoration: TextDecoration.$value,)'),
  );

  final extensionDecorationStyleBuilder = TextStyleExtensionBuilder(
    name: 'DecorationStyleExtension',
    values: ['solid', 'double', 'dotted', 'dashed', 'wavy'],
    mapper: (value) => Code('copyWith(decorationStyle: TextDecorationStyle.$value,)'),
  );

  final extensionFontFamilyBuilder = TextStyleExtensionBuilder(
    name: 'FontFamilyExtension',
    mapper: (value) => Code('copyWith(fontFamily: $value,)'),
    customValues: {
      'nocturne': "'NocturneSerif'",
      'dmsans': "'DMSans'",
    }
  );

  final extensionOverflowBuilder = TextStyleExtensionBuilder(
    name: 'OverflowExtension',
    prefix: 'overflow',
    values: ['clip', 'fade', 'ellipsis', 'visible'],
    mapper: (value) => Code('copyWith(overflow: TextOverflow.$value,)'),
  );


  print(assembleDartCode([
    extensionSizeBuilder,
    extensionWeightBuilder,
    extensionColorBuilder,
    extensionStyleBuilder,
    extensionDecorationBuilder,
    extensionDecorationStyleBuilder,
    extensionFontFamilyBuilder,
    extensionOverflowBuilder,
  ]));
}

String assembleDartCode(List<TextStyleExtensionBuilder> builders) {
  final emitter = DartEmitter();

  final rawDartCodeChunks = builders.map((builder) =>
    builder.build().accept(emitter).toString(),
  ).toList();

  final importDirective = Directive.import('package:flutter/material.dart');
  rawDartCodeChunks.insert(0, importDirective.accept(emitter).toString());

  final rawDartCode = rawDartCodeChunks.reduce((acc, next) => '$acc\n$next');
  return formatDartCode(rawDartCode);
}

String formatDartCode(String code) {
  return DartFormatter().format(code)
    .replaceAll('        ', '    ')
    .replaceAll('      ', '  ')
    .replaceAll(');', ');\n')
    .replaceAll('on TextStyle {', 'on TextStyle {\n');
}