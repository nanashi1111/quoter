import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color tabBarColor = Color.fromRGBO(13, 29, 49, 1.0);
const Color appBarColor = Colors.white;
const Color selectedTabTextColor = Color.fromRGBO(40, 101, 201, 1.0);
const Color unselectedTabTextColor = Color.fromRGBO(13, 29, 47, 1.0);

List<Color> textColors = List.of([
  HexColor("#91C8E4"),
  HexColor("#FF9999"),
  HexColor("#749BC2"),
  HexColor("#4682A9"),
  HexColor("#FBA1B7"),
  HexColor("#FFD1DA"),
  HexColor("#FFF0F5"),
  HexColor("#FFDBAA"),
  HexColor("#E8FFCE"),
  HexColor("#ACFADF"),
  HexColor("#94ADD7"),
  HexColor("#7C73C0"),
  HexColor("#F11A7B"),
  HexColor("#982176"),
  HexColor("#3E001F"),
  HexColor("#FFE5AD"),
  HexColor("#461959"),
  HexColor("#7A316F"),
  HexColor("#CD6688"),
]);

TextStyle textStyleFromFontName(String fontName) {
  int fontIndex = fontNames.indexOf(fontName);
  if (fontIndex >= 0) {
    return textStyles[fontIndex];
  }
  return textStyles.first;
}

List<TextStyle> textStyles = List.of([
  GoogleFonts.montserrat(fontWeight: FontWeight.w600),
  GoogleFonts.bonheurRoyale(fontWeight: FontWeight.w600),
  GoogleFonts.indieFlower(fontWeight: FontWeight.w600),
  GoogleFonts.permanentMarker(fontWeight: FontWeight.w600),
  GoogleFonts.lato(fontWeight: FontWeight.w600),
  GoogleFonts.notoSans(fontWeight: FontWeight.w600),
  GoogleFonts.ubuntu(fontWeight: FontWeight.w600),
  GoogleFonts.eduSaBeginner(fontWeight: FontWeight.w600),
  GoogleFonts.quicksand(fontWeight: FontWeight.w600),
  GoogleFonts.dancingScript(fontWeight: FontWeight.w600),
  GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
  GoogleFonts.vesperLibre(fontWeight: FontWeight.w600),
  GoogleFonts.caveat(fontWeight: FontWeight.w600),
  GoogleFonts.abrilFatface(fontWeight: FontWeight.w600),
  GoogleFonts.shadowsIntoLight(fontWeight: FontWeight.w600),
]);

List<String> fontNames = List.of([
  "montserrat",
  "bonheurRoyale",
  "indieFlower",
  "permanentMarker",
  "lato",
  "notoSans",
  "ubuntu",
  "eduSaBeginner",
  "quicksand",
  "dancingScript",
  "rajdhani",
  "vesperLibre",
  "caveat",
  "abrilFatface",
  "shadowsIntoLight"
]);

extension ColorToString on Color {
  String toHexString() {
    return value.toRadixString(16);
  }
}

extension StringToColor on String {
  Color toColor() {
    return HexColor(this);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
