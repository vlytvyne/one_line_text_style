import 'package:code_builder/code_builder.dart';
import 'package:one_line_text_style/src/olts_config.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';

class TextStyleExtensionBuilderFactory {

  final OltsConfig config;

  TextStyleExtensionBuilderFactory(this.config);

  TextStyleExtensionBuilder get size {
    String prefix;
    List<String> values;
    Map<String, String> customValues = {};
    bool applyPrefixToCustomValues;

    prefix = config.sizeConfig?.prefix ?? 'size';
    if (prefix.isEmpty) {
      prefix = 'size';
    }

    final int minSize = config.sizeConfig?.min ?? 8;
    final int maxSize = config.sizeConfig?.max ?? 56;
    final int step = config.sizeConfig?.step ?? 2;

    values = List.generate(
      (maxSize - minSize) ~/ step + 1,
      (index) => (minSize + index * step).toString(),
    ).toList();

    customValues.addAll(config.sizeConfig?.customValues ?? {});

    applyPrefixToCustomValues =
        config.sizeConfig?.applyPrefixToCustomValues ?? true;

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
    String? prefix;
    Map<String, String> customValues = {};

    prefix = config.colorConfig?.prefix;

    customValues.addAll({
      'white': '0xFFFFFFFF',
      'black': '0xFF000000',
      'grey': '0xFF9E9E9E',
      'red': '0xFFF44336',
    });
    customValues.addAll(config.colorConfig?.customValues ?? {});

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
    String prefix;
    List<String> values = ['100', '200', '300', '400', '500', '600', '700', '800', '900'];
    Map<String, String> customValues = {};
    bool applyPrefixToCustomValues;

    prefix = config.weightConfig?.prefix ?? 'w';
    if (prefix.isEmpty) {
      prefix = 'w';
    }

    customValues.addAll({
      'semibold': '600',
      'bold': '700',
    });
    customValues.addAll(config.weightConfig?.customValues ?? {});

    applyPrefixToCustomValues =
        config.weightConfig?.applyPrefixToCustomValues ?? true;

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
    String? prefix = config.fontFamilyConfig?.prefix;
    Map<String, String>? customValues = config.fontFamilyConfig?.customValues ?? {};

    return TextStyleExtensionBuilder(
      name: 'FontFamilyExtension',
      prefix: prefix,
      mapper: (value) => Code('copyWith(fontFamily: \'$value\',)'),
      customValues: customValues,
    );
  }

  TextStyleExtensionBuilder get style {
    String? prefix = config.styleConfig?.prefix;

    return TextStyleExtensionBuilder(
      name: 'StyleExtension',
      prefix: prefix,
      values: ['italic',],
      mapper: (value) => Code('copyWith(fontStyle: FontStyle.$value,)'),
    );
  }

  TextStyleExtensionBuilder get decoration {
    String? prefix = config.decorationConfig?.prefix;

    return TextStyleExtensionBuilder(
      name: 'DecorationExtension',
      prefix: prefix,
      values: ['underline', 'overline', 'lineThrough',],
      mapper: (value) => Code('copyWith(decoration: TextDecoration.$value,)'),
    );
  }

  TextStyleExtensionBuilder get decorationStyle {
    String? prefix = config.decorationStyleConfig?.prefix;

    return TextStyleExtensionBuilder(
      name: 'DecorationStyleExtension',
      prefix: prefix,
      values: ['solid', 'double', 'dotted', 'dashed', 'wavy'],
      mapper: (value) => Code('copyWith(decorationStyle: TextDecorationStyle.$value,)'),
    );
  }

  TextStyleExtensionBuilder get overflow {
    String prefix = config.overflowConfig?.prefix ?? 'overflow';

    return TextStyleExtensionBuilder(
      name: 'OverflowExtension',
      prefix: prefix,
      values: ['clip', 'fade', 'ellipsis', 'visible'],
      mapper: (value) => Code('copyWith(overflow: TextOverflow.$value,)'),
    );
  }

}