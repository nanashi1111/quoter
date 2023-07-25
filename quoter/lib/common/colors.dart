
import 'dart:ui';

import 'package:flutter/material.dart';

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