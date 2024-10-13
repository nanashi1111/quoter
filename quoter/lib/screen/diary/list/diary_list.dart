import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/screen/diary/list/diary_item.dart';

class DiaryList extends StatelessWidget {
  final List<Diary> diaries;
  final Function(Diary) onSelected;

  const DiaryList({super.key, required this.diaries, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    if (diaries.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset("assets/images/ic_empty_data.svg", width: 60, height: 60, color: Colors.white.withOpacity(0.8)),
            verticalSpacing(10),
            Text("Write a day on your card", style: GoogleFonts.lato(fontSize: 15, color: Colors.white.withOpacity(0.8)),)
          ],
        ),
      );
    }
    return ListView.separated(
        itemBuilder: (context, pos) {
          return GestureDetector(
            child: DiaryItem(diary: diaries[pos]),
            onTap: () {
              onSelected(diaries[pos]);
            },
          );
        },
        separatorBuilder: (context, pos) {
          return SizedBox(
            height: 1,
          );
        },
        itemCount: diaries.length);
  }
}
