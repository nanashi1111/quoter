part of 'create_diary_bloc.dart';

@freezed
class CreateDiaryState with _$CreateDiaryState {
  const factory CreateDiaryState.initial({required Diary cacheDiary, required int currentPos, required bool savedDiary}) = _Initial;
}
