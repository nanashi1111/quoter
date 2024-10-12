import 'package:flutter/material.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/screen/diary/list/diary_item.dart';

class DiaryList extends StatelessWidget {
  final List<Diary> diaries;
  final Function(Diary) onSelected;

  const DiaryList({super.key, required this.diaries, required this.onSelected});

  @override
  Widget build(BuildContext context) {
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
