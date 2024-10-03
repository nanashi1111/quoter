import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white
          )
      ),
      child: Text("Quoter", style: GoogleFonts.plaster(
          fontSize: 30,
        color: Colors.white
      ),),
    ),);
  }
}