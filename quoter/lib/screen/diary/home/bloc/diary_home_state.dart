part of 'diary_home_bloc.dart';

@freezed
class DiaryHomeState with _$DiaryHomeState {
  const factory DiaryHomeState.data({
    required int year,
    required bool showingCalendar,
    required List<DiaryCard> cards}) = _Data;
}
