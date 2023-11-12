import 'package:code_builder/code_builder.dart';
import 'package:one_line_text_style/src/text_style_extention_builder.dart';

final extensionSizeBuilder = TextStyleExtensionBuilder(
  name: 'SizeExtension',
  prefix: 'size',
  values: ['8'],
  mapper: (value) => Code('copyWith(fontSize: $value,)'),
);

final extensionColorBuilder = TextStyleExtensionBuilder(
  name: 'ColorExtension',
  mapper: (value) => Code('copyWith(color: const Color($value),)'),
  customValues: {
    'white': '0xFFFFFFFF',
    'black': '0xFF000000',
    'grey': '0xFF9E9E9E',
    'red': '0xFFF44336',
  },
);

final extensionFontFamilyBuilder = TextStyleExtensionBuilder(
  name: 'FontFamilyExtension',
  mapper: (value) => Code('copyWith(fontFamily: $value,)'),
  customValues: {
    'nocturne': "'NocturneSerif'",
    'dmsans': "'DMSans'",
  },
);

final extensionWeightBuilder = TextStyleExtensionBuilder(
  name: 'WeightExtension',
  prefix: 'w',
  values: ['100', '200', '300', '400', '500', '600', '700', '800', '900'],
  mapper: (value) => Code('copyWith(fontWeight: FontWeight.w$value,)'),
  customValues: {
    'semibold': '600',
    'bold': '700',
  },
  applyPrefixToCustomValues: false,
);

final extensionStyleBuilder = TextStyleExtensionBuilder(
  name: 'StyleExtension',
  values: ['italic',],
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

final extensionOverflowBuilder = TextStyleExtensionBuilder(
  name: 'OverflowExtension',
  prefix: 'overflow',
  values: ['clip', 'fade', 'ellipsis', 'visible'],
  mapper: (value) => Code('copyWith(overflow: TextOverflow.$value,)'),
);