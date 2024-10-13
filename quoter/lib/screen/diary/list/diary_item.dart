import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/date_time_ext.dart';
import 'package:quoter/common/diary_ext.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary.dart';

const DIARY_ITEM_HEIGHT = 140.0;

class DiaryItem extends StatelessWidget {
  final Diary diary;

  const DiaryItem({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        height: DIARY_ITEM_HEIGHT,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1),
            boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.9), blurRadius: 5, spreadRadius: 2, offset: const Offset(0, 0))]),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${diary.day}",
                    style: GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 30, color: darkCommonColor),
                  ),
                  verticalSpacing(10),
                  Text(
                    getDayOfWeek(DateTime(diary.year, diary.month, diary.day)).substring(0,3).toUpperCase(),
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17, color: darkCommonColor),
                  )
                ],
              ),
            ),
            Container(
              width: 1,
              height: DIARY_ITEM_HEIGHT,
              color: darkCommonColor,
            ),
            Expanded(
              flex: 5,
              child: _provideDiaryContent(),
            )
          ],
        ),
      ),
    );
  }

  _provideDiaryContent() {
    if (diary.hasImage()) {
      String image = diary.firstImage();
      debugPrint("Start: ${DateTime.now().millisecond}");
      Uint8List data = base64Decode(image);
      debugPrint("End: ${DateTime.now().millisecond}");

      return SizedBox(
        width: double.infinity,
        height: DIARY_ITEM_HEIGHT,
        child: ClipRRect(borderRadius: BorderRadius.circular(1), child: Image.memory(data, fit: BoxFit.cover, width: double.infinity, height: DIARY_ITEM_HEIGHT)),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: DIARY_ITEM_HEIGHT,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/images/ic_quote_open.svg",
                    width: 15,
                    height: 15,
                    color: darkCommonColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            verticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diary.title,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 20, color: darkCommonColor.withOpacity(0.5)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpacing(5),
                  Text(
                    diary.content,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: 15, color: darkCommonColor.withOpacity(0.5)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            verticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/ic_quote_close.svg",
                    width: 15,
                    height: 15,
                    color: darkCommonColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
