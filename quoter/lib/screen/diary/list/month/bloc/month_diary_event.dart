part of 'month_diary_bloc.dart';

@freezed
class MonthDiaryEvent with _$MonthDiaryEvent {
  const factory MonthDiaryEvent.started({required int month, required int year}) = _Started;
}
