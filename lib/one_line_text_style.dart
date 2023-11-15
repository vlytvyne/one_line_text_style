import 'package:flutter/material.dart';

extension SizeExtension on TextStyle {

  TextStyle get s8 => copyWith(
    fontSize: 8,
  );

  TextStyle get s10 => copyWith(
    fontSize: 10,
  );

  TextStyle get s12 => copyWith(
    fontSize: 12,
  );

  TextStyle get s14 => copyWith(
    fontSize: 14,
  );

  TextStyle get s16 => copyWith(
    fontSize: 16,
  );

  TextStyle get s18 => copyWith(
    fontSize: 18,
  );

  TextStyle get s20 => copyWith(
    fontSize: 20,
  );

  TextStyle get s22 => copyWith(
    fontSize: 22,
  );

  TextStyle get s24 => copyWith(
    fontSize: 24,
  );

  TextStyle get s26 => copyWith(
    fontSize: 26,
  );

  TextStyle get s28 => copyWith(
    fontSize: 28,
  );

  TextStyle get s30 => copyWith(
    fontSize: 30,
  );

  TextStyle get sMedium => copyWith(
    fontSize: 30,
  );

  TextStyle get sLarge => copyWith(
    fontSize: 40,
  );

}

extension WeightExtension on TextStyle {

  TextStyle get w100 => copyWith(
    fontWeight: FontWeight.w100,
  );

  TextStyle get w200 => copyWith(
    fontWeight: FontWeight.w200,
  );

  TextStyle get w300 => copyWith(
    fontWeight: FontWeight.w300,
  );

  TextStyle get w400 => copyWith(
    fontWeight: FontWeight.w400,
  );

  TextStyle get w500 => copyWith(
    fontWeight: FontWeight.w500,
  );

  TextStyle get w600 => copyWith(
    fontWeight: FontWeight.w600,
  );

  TextStyle get w700 => copyWith(
    fontWeight: FontWeight.w700,
  );

  TextStyle get w800 => copyWith(
    fontWeight: FontWeight.w800,
  );

  TextStyle get w900 => copyWith(
    fontWeight: FontWeight.w900,
  );

  TextStyle get semibold => copyWith(
    fontWeight: FontWeight.w600,
  );

  TextStyle get bold => copyWith(
    fontWeight: FontWeight.w700,
  );

  TextStyle get extraThin => copyWith(
    fontWeight: FontWeight.w100,
  );

}

extension ColorExtension on TextStyle {

  TextStyle get colWhite => copyWith(
    color: const Color(0xFFFFFFFF),
  );

  TextStyle get colBlack => copyWith(
    color: const Color(0xFF000000),
  );

  TextStyle get colGrey => copyWith(
    color: const Color(0xFF9E9E9E),
  );

  TextStyle get colRed => copyWith(
    color: const Color(0xFFF44336),
  );

  TextStyle get colYellow => copyWith(
    color: const Color(0xFFAAAAAA),
  );

}

extension FontFamilyExtension on TextStyle {

  TextStyle get ffDmsans => copyWith(
    fontFamily: 'DM Sans',
  );

}

extension StyleExtension on TextStyle {

  TextStyle get italic => copyWith(
    fontStyle: FontStyle.italic,
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

  TextStyle get dsSolid => copyWith(
    decorationStyle: TextDecorationStyle.solid,
  );

  TextStyle get dsDouble => copyWith(
    decorationStyle: TextDecorationStyle.double,
  );

  TextStyle get dsDotted => copyWith(
    decorationStyle: TextDecorationStyle.dotted,
  );

  TextStyle get dsDashed => copyWith(
    decorationStyle: TextDecorationStyle.dashed,
  );

  TextStyle get dsWavy => copyWith(
    decorationStyle: TextDecorationStyle.wavy,
  );

}

extension OverflowExtension on TextStyle {

  TextStyle get overClip => copyWith(
    overflow: TextOverflow.clip,
  );

  TextStyle get overFade => copyWith(
    overflow: TextOverflow.fade,
  );

  TextStyle get overEllipsis => copyWith(
    overflow: TextOverflow.ellipsis,
  );

  TextStyle get overVisible => copyWith(
    overflow: TextOverflow.visible,
  );

}
