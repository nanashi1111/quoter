
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';

class YearSelector extends StatelessWidget {

  final int year;
  final Function(int) onYearSelected;

  const YearSelector({super.key, required this.year, required this.onYearSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text("$year", style: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 25, fontWeight: FontWeight.bold),),
          horizontalSpacing(10),
          Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white.withOpacity(0.8),),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Select Year"),
              content: Container( // Need to use container to add size constraint.
                width: 300,
                height: 300,
                child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 100, 1),
                  lastDate: DateTime(DateTime.now().year + 100, 1),
                  initialDate: DateTime.now(),
                  // save the selected date to _selectedDate DateTime variable.
                  // It's used to set the previous selected date when
                  // re-showing the dialog.
                  selectedDate: DateTime(year),
                  onChanged: (DateTime dateTime) {
                    onYearSelected(dateTime.year);
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}