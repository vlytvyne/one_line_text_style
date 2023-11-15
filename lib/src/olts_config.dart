class OltsConfig {

  final SizeConfig? sizeConfig;
  final ColorConfig? colorConfig;
  final WeightConfig? weightConfig;
  final FontFamilyConfig? fontFamilyConfig;
  final OverflowConfig? overflowConfig;
  final StyleConfig? styleConfig;
  final DecorationConfig? decorationConfig;
  final DecorationStyleConfig? decorationStyleConfig;

  OltsConfig({
    this.sizeConfig,
    this.colorConfig,
    this.weightConfig,
    this.fontFamilyConfig,
    this.overflowConfig,
    this.styleConfig,
    this.decorationConfig,
    this.decorationStyleConfig
  });

}

mixin _PrefixMixin {

  String? prefix;

}

mixin _ApplyPrefixMixin {

  bool? applyPrefixToCustomValues;

}

mixin _CustomValuesMixin {

  Map<String, String>? customValues;

}

class SizeConfig with _PrefixMixin, _ApplyPrefixMixin, _CustomValuesMixin{

  int? min;
  int? max;
  int? step;

}

class ColorConfig with _PrefixMixin, _CustomValuesMixin {}
class WeightConfig with _PrefixMixin, _CustomValuesMixin, _ApplyPrefixMixin {}
class FontFamilyConfig with _PrefixMixin, _CustomValuesMixin {}
class OverflowConfig with _PrefixMixin {}
class StyleConfig with _PrefixMixin {}
class DecorationConfig with _PrefixMixin {}
class DecorationStyleConfig with _PrefixMixin {}

