
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';

Widget verticalSpacing(double spacing) {
  return SizedBox(height: spacing,);
}
Widget horizontalSpacing(double spacing) {
  return SizedBox(width: spacing,);
}

TextStyle defaultTextStyle() {
  return textStyles.first.copyWith(fontSize: 22, color: Colors.white);
}

String defaultFontName() {
  return fontNames.first;
}

Color defaultBackgroundColor() {
  return Colors.black.withOpacity(0.5);
}