import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenuVersion extends StatelessWidget {
  const SideMenuVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Version: 1.0.0",
        style: GoogleFonts.montserrat(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
