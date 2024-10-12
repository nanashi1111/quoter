import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/date_time_ext.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/diary_card.dart';
import 'package:quoter/repositories/diary_repository.dart';

part 'diary_home_event.dart';

part 'diary_home_state.dart';

part 'diary_home_bloc.freezed.dart';

class DiaryHomeBloc extends Bloc<DiaryHomeEvent, DiaryHomeState> {
  final DiaryRepository diaryRepository = getIt.get();

  DiaryHomeBloc() : super(DiaryHomeState.data(year: getCurrentYear(), showingCalendar: false, cards: [])) {
    on<_GetCardsOfYear>((event, emit) async {
      int year = event.year ?? getCurrentYear();
      List<DiaryCard> cards = await diaryRepository.getDiaryCards(year);
      emit(state.copyWith(year: year, cards: cards));
    });

    on<_SwitchViewMode>((event, emit) async {
      emit(state.copyWith(showingCalendar: !state.showingCalendar));
    });
  }
}
