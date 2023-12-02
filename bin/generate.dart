import 'dart:io';

import 'package:args/args.dart';
import 'package:one_line_text_style/src/code_generator.dart';
import 'package:one_line_text_style/src/text_style_extention_builder_factory.dart';
import 'package:one_line_text_style/src/yaml_config_parser.dart';

const _configPathOption = 'config-path';
const _resultPathOption = 'result-path';

Future<void> main(List<String> args) async {
  final parser = ArgParser();

  parser
    ..addOption(_configPathOption)
    ..addOption(_resultPathOption)
    ..addFlag(
      'help',
      abbr: 'h',
    );

  final parsedArgs = parser.parse(args);

  if (parsedArgs['help']) {
    print('Usage:\n  dart run one_line_text_style:generate --$_configPathOption <file> --$_resultPathOption <file>');
    exit(0);
  }

  final configPath = parsedArgs[_configPathOption];
  final resultPath = parsedArgs[_resultPathOption];

  final yamlConfigParser = YamlConfigParser(configPath);
  final oltsConfig = yamlConfigParser.parseOltsConfig();
  final extensionFactory = TextStyleExtensionBuilderFactory(oltsConfig);

  final codeGenerator = CodeGenerator([
    extensionFactory.size,
    extensionFactory.weight,
    extensionFactory.color,
    extensionFactory.fontFamily,
    extensionFactory.style,
    extensionFactory.decoration,
    extensionFactory.decorationStyle,
    extensionFactory.overflow,
  ]);

  final formattedCode = codeGenerator.generate();

  final resultFile = File(resultPath ?? 'lib/one_line_text_style.dart');

  resultFile
    ..createSync(recursive: true)
    ..writeAsStringSync(formattedCode);

  print('Successfully generated: ${resultFile.path}!');
}