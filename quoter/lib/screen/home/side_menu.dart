import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/models/side_menu_model.dart';
import 'package:quoter/screen/home/side_menu_header.dart';
import 'package:quoter/screen/home/side_menu_item.dart';
import 'package:quoter/screen/home/side_menu_version.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.65,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
                  children: [
                    SideMenuHeader(),
                    SideMenuItem(model: SideMenuModel(icon: 'assets/images/ic_my_quotes.svg', title: 'My quotes'), onClick: () {}),
                    SideMenuItem(model: SideMenuModel(icon: 'assets/images/ic_remove_ads.svg', title: 'Remove ads'), onClick: () {}),
                    SideMenuItem(model: SideMenuModel(icon: 'assets/images/ic_policy.svg', title: 'Privacy & Policy'), onClick: () {})
                  ],
                )),
            const SideMenuVersion()
          ],
        ));
  }
}
