import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/date_time_ext.dart';

class DiaryDate extends StatelessWidget {
  final DateTime dateTime;

  const DiaryDate({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            getDateInString(dateTime).toUpperCase(),
            style: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
