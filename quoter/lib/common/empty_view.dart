import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      alignment: Alignment.topCenter,
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/ic_my_quotes.svg',
            width: 70,
            height: 70,
            color: Colors.white.withOpacity(0.8),
          ),
          verticalSpacing(20),
          Text(
            "No quotes found",

            style: GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w700,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}
