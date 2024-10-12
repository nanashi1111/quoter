import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';

Widget verticalSpacing(double spacing) {
  return SizedBox(
    height: spacing,
  );
}

Widget horizontalSpacing(double spacing) {
  return SizedBox(
    width: spacing,
  );
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

AppBar commonAppbar(BuildContext context, String title, {List<Widget>? actions}) {
  return AppBar(
    leading: GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        child: SvgPicture.asset(
          'assets/images/ic_back.svg',
          color: Colors.white,
          width: 25,
          height: 25,
        ),
      ),
      onTap: () {
        context.pop();
      },
    ),
    title: Text(
      title,
      style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
    ),
    centerTitle: Platform.isIOS,
    backgroundColor: darkCommonColor,
    actions: actions ?? [],
  );
}
