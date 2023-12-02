import 'dart:io';

import 'package:one_line_text_style/src/olts_config.dart';
import 'package:yaml/yaml.dart';

class _YamlKeys {

  static const String size = 'size';
  static const String color = 'color';
  static const String weight = 'weight';
  static const String fontFamily = 'font_family';
  static const String overflow = 'overflow';
  static const String style = 'style';
  static const String decoration = 'decoration';
  static const String decorationStyle = 'decoration_style';

  static const List<String> topLevelKeys = [
    size,
    color,
    weight,
    fontFamily,
    overflow,
    style,
    decoration,
    decorationStyle,
  ];

  static const String prefix = 'prefix';
  static const String step = 'step';
  static const String min = 'min';
  static const String max = 'max';
  static const String applyPrefixToCustomValues = 'apply_prefix_to_custom_values';
  static const String customValues = 'custom_values';
}

class YamlConfigParser {

  final String? userDefinedFilePath;

  YamlConfigParser(this.userDefinedFilePath);

  OltsConfig parseOltsConfig() {
    final dataMap = _extractConfig();

    for (var key in _YamlKeys.topLevelKeys) {
      dataMap.putIfAbsent(key, () => {});
    }

    SizeConfig sizeConfig = SizeConfig()
      ..prefix = dataMap[_YamlKeys.size][_YamlKeys.prefix]
      ..customValues = _convertToStringMap(dataMap[_YamlKeys.size][_YamlKeys.customValues])
      ..applyPrefixToCustomValues = dataMap[_YamlKeys.size][_YamlKeys.applyPrefixToCustomValues]
      ..min = dataMap[_YamlKeys.size][_YamlKeys.min] as int?
      ..max = dataMap[_YamlKeys.size][_YamlKeys.max] as int?
      ..step = dataMap[_YamlKeys.size][_YamlKeys.step] as int?;

    ColorConfig colorConfig = ColorConfig()
      ..prefix = dataMap[_YamlKeys.color][_YamlKeys.prefix]
      ..customValues = _convertToStringMap(dataMap[_YamlKeys.color][_YamlKeys.customValues]);

    WeightConfig weightConfig = WeightConfig()
      ..prefix = dataMap[_YamlKeys.weight][_YamlKeys.prefix]
      ..customValues = _convertToStringMap(dataMap[_YamlKeys.weight][_YamlKeys.customValues])
      ..applyPrefixToCustomValues = dataMap[_YamlKeys.weight][_YamlKeys.applyPrefixToCustomValues];

    FontFamilyConfig fontFamilyConfig = FontFamilyConfig()
      ..prefix = dataMap[_YamlKeys.fontFamily][_YamlKeys.prefix]
      ..customValues = _convertToStringMap(dataMap[_YamlKeys.fontFamily][_YamlKeys.customValues]);

    OverflowConfig overflowConfig = OverflowConfig()
      ..prefix = dataMap[_YamlKeys.overflow][_YamlKeys.prefix];

    StyleConfig styleConfig = StyleConfig()
      ..prefix = dataMap[_YamlKeys.style][_YamlKeys.prefix];

    DecorationConfig decorationConfig = DecorationConfig()
      ..prefix = dataMap[_YamlKeys.decoration][_YamlKeys.prefix];

    DecorationStyleConfig decorationStyleConfig = DecorationStyleConfig()
      ..prefix = dataMap[_YamlKeys.decorationStyle][_YamlKeys.prefix];

    return OltsConfig(
      sizeConfig: sizeConfig,
      colorConfig: colorConfig,
      weightConfig: weightConfig,
      fontFamilyConfig: fontFamilyConfig,
      overflowConfig: overflowConfig,
      styleConfig: styleConfig,
      decorationConfig: decorationConfig,
      decorationStyleConfig: decorationStyleConfig,
    );
  }

  Map<String, String> _convertToStringMap(Map<String, dynamic>? dataMap) {
    if (dataMap == null) {
      return {};
    }
    return Map.fromEntries(dataMap.entries.map((e) => MapEntry(e.key, e.value.toString())));
  }
  
  Map<String, dynamic> _extractConfig() {
    File file;

    if (userDefinedFilePath != null) {
      if (File(userDefinedFilePath!).existsSync()) {
        file = File(userDefinedFilePath!);
      } else {
        throw Exception('The config file `$userDefinedFilePath` was not found.');
      }
    /// At the project root
    } else if (File('one_line_text_style.yaml').existsSync()) {
      file = File('one_line_text_style.yaml');
    } else {
      file = File('pubspec.yaml');
    }

    final Map yamlMap = loadYaml(file.readAsStringSync()) as Map;

    if (yamlMap['one_line_text_style'] is! Map) {
      print('Your `${file.path}` file does not contain a `one_line_text_style` section.\nDefault configuration is used');
      return {};
    }

    return _convertYamlToMap(yamlMap['one_line_text_style'] as YamlMap);
  }

  Map<String, dynamic> _convertYamlToMap(YamlMap yamlMap) {
    final Map<String, dynamic> map = {};

    for (final entry in yamlMap.entries) {
      if (entry.value is YamlList) {
        final List<String> list = (entry.value as YamlList)
          .nodes.map((e) => e.value as String)
          .toList();
        map[entry.key] = list;
      } else if (entry.value is YamlMap) {
        map[entry.key] = _convertYamlToMap(entry.value as YamlMap);
      } else {
        map[entry.key] = entry.value;
      }
    }
    return map;
  }

}