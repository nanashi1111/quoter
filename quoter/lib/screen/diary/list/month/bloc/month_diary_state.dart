part of 'month_diary_bloc.dart';

@freezed
class MonthDiaryState with _$MonthDiaryState {
  const factory MonthDiaryState.initial({required List<Diary> diaries}) = _Initial;
}
