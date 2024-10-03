import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';

class GoPremiumItem extends StatelessWidget {
  final Function onClick;
  final String title;
  final String header;
  final String price;
  final String description;

  final List<Color> colors;
  final Color headerColor;

  const GoPremiumItem(
      {super.key,
      required this.onClick,
      required this.title,
      required this.price,
      required this.description,
      required this.colors,
      required this.headerColor,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700).copyWith(color: headerColor),
          ),
          verticalSpacing(10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)), gradient: LinearGradient(colors: colors, begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_premium.svg',
                        width: 25,
                        height: 25,
                        color: Colors.white,
                      ),
                      horizontalSpacing(10),
                      Text(
                        title,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
                      ),
                      Expanded(
                        child: Text(
                          price,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  verticalSpacing(10),
                  Text(
                    description,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            ),
            onTap: () {
              onClick();
            },
          )
        ],
      ),
    );
  }
}
