import 'package:args/args.dart';
import 'package:one_line_text_style/src/code_generator.dart';
import 'package:one_line_text_style/src/text_style_extention_builder_factory.dart';
import 'package:one_line_text_style/src/yaml_config_parser.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();

  parser.addOption('config-path');
  parser.addOption('result-path');

  final parsedArgs = parser.parse(args);

  final yamlConfigParser = YamlConfigParser(parsedArgs['config-path']);
  final oltsConfig = yamlConfigParser.parseOltsConfig();

  print(CodeGenerator(TextStyleExtensionBuilderFactory(oltsConfig)).generate());
}