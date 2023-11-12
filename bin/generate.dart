import 'dart:io';

import 'package:args/args.dart';
import 'package:one_line_text_style/src/code_generator.dart';
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();

  parser.addOption('config-path');
  parser.addOption('result-path');

  final parsedArgs = parser.parse(args);

  final config = _extractConfig(parsedArgs['config-path']);
  // print(config['color']['values']['red']);

  print(CodeGenerator(config).generate());
}


/// https://github.com/jonbhanson/flutter_native_splash/blob/master/lib/cli_commands.dart
Map<String, dynamic> _extractConfig(String? configFilePath,) {
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

  return _convertYamlToMap(yamlMap['one_line_text_style'] as YamlMap);
}

Map<String, dynamic> _convertYamlToMap(YamlMap yamlMap) {
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
      map[entry.key as String] = _convertYamlToMap(entry.value as YamlMap);
    } else {
      map[entry.key as String] = entry.value;
    }
  }
  return map;
}