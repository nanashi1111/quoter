import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary.dart';

class DiaryContent extends StatelessWidget {
  final Diary? diary;
  final TextEditingController contentController;
  final TextEditingController titleController;

  const DiaryContent({super.key, this.diary, required this.contentController, required this.titleController});

  @override
  Widget build(BuildContext context) {
    contentController.value = TextEditingValue(text: diary?.content ?? '');
    titleController.value = TextEditingValue(text: diary?.title ?? '');
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.bold),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          verticalSpacing(20),
          Expanded(
              child: TextField(
                  controller: contentController,
                  style: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Write your today...',
                    hintStyle: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.normal),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  )))
        ],
      ),
    );
  }
}
