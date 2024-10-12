import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/repositories/diary_repository.dart';

part 'month_diary_event.dart';

part 'month_diary_state.dart';

part 'month_diary_bloc.freezed.dart';

class MonthDiaryBloc extends Bloc<MonthDiaryEvent, MonthDiaryState> {
  final DiaryRepository diaryRepository = getIt.get();

  MonthDiaryBloc() : super(const MonthDiaryState.initial(diaries: [])) {
    on<_Started>((event, emit) async {
      List<Diary> diaries = await diaryRepository.getDiaries(event.month, event.year);
      emit(state.copyWith(diaries: diaries));
    });
  }
}
