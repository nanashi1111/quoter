
import 'dart:ui';

import 'package:flutter/material.dart';

const Color tabBarColor = Color.fromRGBO(13, 29, 49, 1.0);
const Color appBarColor = Colors.white;
const Color selectedTabTextColor = Color.fromRGBO(40, 101, 201, 1.0);
const Color unselectedTabTextColor = Color.fromRGBO(13, 29, 47, 1.0);

List<Color> textColors = List.of([
  HexColor("#33FF66"),
  HexColor("#FF9999"),
  HexColor("#9900CC"),
  HexColor("#708090"),
  HexColor("#CC3366"),
  HexColor("#666699"),
  HexColor("#339933"),
  HexColor("#FF99FF"),
  HexColor("#66CC33"),
  HexColor("#CCCCCC"),
  HexColor("#66FF00"),
  HexColor("#CC0000"),
  HexColor("#FFFF00"),
  HexColor("#FFCC00"),
  HexColor("#CC33CC"),
  HexColor("#006600"),
  HexColor("#B9D3EE"),
  HexColor("#8B4513"),
  HexColor("#63B8FF"),
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