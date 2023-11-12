library one_line_text_style;

import 'package:flutter/material.dart';

/// CONFIGABLE
extension SizeExtension on TextStyle {

  TextStyle get size14 => copyWith(
    fontSize: 14,
  );

  TextStyle get size16 => copyWith(
    fontSize: 16,
  );

  TextStyle get size18 => copyWith(
    fontSize: 18,
  );

}

extension WeightExtension on TextStyle {

  TextStyle get w600 => copyWith(
    fontWeight: FontWeight.w600,
  );

  TextStyle get w700 => copyWith(
    fontWeight: FontWeight.w700,
  );

  TextStyle get semibold => copyWith(
    fontWeight: FontWeight.w600,
  );

}

/// CONFIGABLE
extension ColorExtension on TextStyle {

  TextStyle get white => copyWith(
    color: const Color(0xFFFFFFFF),
  );

  TextStyle get black => copyWith(
    color: const Color(0xFF000000),
  );

  TextStyle get grey => copyWith(
    color: const Color(0xFF9E9E9E),
  );

  TextStyle get red => copyWith(
    color: const Color(0xFFF44336),
  );

}

extension StyleExtension on TextStyle {

  TextStyle get italic => copyWith(
    fontStyle: FontStyle.italic,
  );

  TextStyle get normal => copyWith(
    fontStyle: FontStyle.normal,
  );

}

extension DecorationExtension on TextStyle {

  TextStyle get underline => copyWith(
    decoration: TextDecoration.underline,
  );

  TextStyle get overline => copyWith(
    decoration: TextDecoration.overline,
  );

  TextStyle get lineThrough => copyWith(
    decoration: TextDecoration.lineThrough,
  );

}

extension DecorationStyleExtension on TextStyle {

  TextStyle get solid => copyWith(
    decorationStyle: TextDecorationStyle.solid,
  );

  TextStyle get double => copyWith(
    decorationStyle: TextDecorationStyle.double,
  );

  TextStyle get dotted => copyWith(
    decorationStyle: TextDecorationStyle.dotted,
  );

  TextStyle get dashed => copyWith(
    decorationStyle: TextDecorationStyle.dashed,
  );

  TextStyle get wavy => copyWith(
    decorationStyle: TextDecorationStyle.wavy,
  );

}

/// CONFIGABLE
extension FontFamilyExtension on TextStyle {

  TextStyle get nocturne => copyWith(
    fontFamily: 'NocturneSerif',
  );

  TextStyle get dmsans => copyWith(
    fontFamily: 'DMSans',
  );

}

extension OverflowExtension on TextStyle {

  TextStyle get overflowClip => copyWith(
    overflow: TextOverflow.clip,
  );

  TextStyle get overflowFade => copyWith(
    overflow: TextOverflow.fade,
  );

  TextStyle get overflowEllipsis => copyWith(
    overflow: TextOverflow.ellipsis,
  );

  TextStyle get overflowVisible => copyWith(
    overflow: TextOverflow.visible,
  );

}