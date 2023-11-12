import 'package:code_builder/code_builder.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';

class TextStyleExtensionBuilderFactory {

  final Map<String, dynamic> config;

  TextStyleExtensionBuilderFactory(this.config);

  TextStyleExtensionBuilder get size {
    final sizeConfig = config['size'];

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

  TextStyleExtensionBuilder get color {
    final colorConfig = config['color'];

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

  TextStyleExtensionBuilder get weight {
    final weightConfig = config['weight'];

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

  TextStyleExtensionBuilder get fontFamily {
    final fontFamilyConfig = config['font_family'];

    String? prefix = fontFamilyConfig?['prefix'];
    Map<String, String>? customValues = _convertToStringMap(fontFamilyConfig?['custom_values']);

    return TextStyleExtensionBuilder(
      name: 'FontFamilyExtension',
      prefix: prefix,
      mapper: (value) => Code('copyWith(fontFamily: \'$value\',)'),
      customValues: customValues,
    );
  }

  TextStyleExtensionBuilder get style {
    final styleConfig = config['style'];

    String? prefix = styleConfig?['prefix'];

    return TextStyleExtensionBuilder(
      name: 'StyleExtension',
      prefix: prefix,
      values: ['italic',],
      mapper: (value) => Code('copyWith(fontStyle: FontStyle.$value,)'),
    );
  }

  TextStyleExtensionBuilder get decoration {
    final decorationConfig = config['decoration'];

    String? prefix = decorationConfig?['prefix'];

    return TextStyleExtensionBuilder(
      name: 'DecorationExtension',
      prefix: prefix,
      values: ['underline', 'overline', 'lineThrough',],
      mapper: (value) => Code('copyWith(decoration: TextDecoration.$value,)'),
    );
  }

  TextStyleExtensionBuilder get decorationStyle {
    final decorationStyleConfig = config['decoration_style'];

    String? prefix = decorationStyleConfig?['prefix'];

    return TextStyleExtensionBuilder(
      name: 'DecorationStyleExtension',
      prefix: prefix,
      values: ['solid', 'double', 'dotted', 'dashed', 'wavy'],
      mapper: (value) => Code('copyWith(decorationStyle: TextDecorationStyle.$value,)'),
    );
  }

  TextStyleExtensionBuilder get overflow {
    final overflowConfig = config['overflow'];

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

}