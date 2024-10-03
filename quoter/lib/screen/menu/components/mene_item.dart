import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatefulWidget {
  final String title;
  final Function onClick;

  const MenuItem({super.key, required this.title, required this.onClick});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {

  bool pressingDown = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        debugPrint("Pressed");
        widget.onClick();
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      splashColor: Colors.white.withOpacity(0.5),
      child: pressingDown ? Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white.withOpacity(1))),
        width: screenWidth * 2 / 3,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 13),
        ),
      ): Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0), borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white.withOpacity(0.5))),
        width: screenWidth * 2 / 3,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
