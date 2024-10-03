import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/side_menu_model.dart';

class SideMenuItem extends StatelessWidget {
  final SideMenuModel model;
  final Function onClick;

  const SideMenuItem({super.key, required this.model, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                model.icon ?? "",
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 25,
                height: 25,
              ),
              horizontalSpacing(10),
              Text(
                model.title ?? "",
                style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
              )
            ],
          ),
        ),
        onTap: () {
          onClick();
          Scaffold.of(context).closeDrawer();
        },
      );
    });

  }
}
