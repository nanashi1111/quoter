import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/date_time_ext.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/screen/diary/list/diary_list.dart';
import 'package:quoter/screen/diary/list/month/bloc/month_diary_bloc.dart';

class MonthDiariesScreen extends StatelessWidget {
  final int month;
  final int year;

  const MonthDiariesScreen({super.key, required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MonthDiaryBloc>(
      create: (context) => MonthDiaryBloc()..add(MonthDiaryEvent.started(month: month, year: year)),
      child: BlocBuilder<MonthDiaryBloc, MonthDiaryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: commonAppbar(context, "${getMonthInString(month)} / $year".toUpperCase(), actions: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                onTap: () async {

                  DateTime? selectedDate = await showDatePickerForDiary(context);
                  if (selectedDate == null) {
                    return;
                  }
                  Diary diary = Diary(id: 0, day: selectedDate.day, month: selectedDate.month, year: selectedDate.year, content: "", title: "", images: "");
                  await context.push("/create_diary", extra: diary);
                  if (!context.mounted) {
                    return;
                  }
                  context.read<MonthDiaryBloc>().add(MonthDiaryEvent.started(month: month, year: year));
                },
              )
            ]),
            backgroundColor: darkCommonColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DiaryList(
                diaries: state.diaries,
                onSelected: (diary) async {
                  await context.push("/create_diary", extra: diary);
                  if (!context.mounted) {
                    return;
                  }
                  context.read<MonthDiaryBloc>().add(MonthDiaryEvent.started(month: month, year: year));
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<DateTime?> showDatePickerForDiary(BuildContext context) {
    return showDatePicker(context: context,
        helpText: "Select a date to write",
        firstDate: DateTime(year, month, 1),
        lastDate: DateTime(year, month, getNumberOfDayInMonth(month, year)));
  }
}
