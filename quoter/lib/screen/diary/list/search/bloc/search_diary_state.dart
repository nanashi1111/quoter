part of 'search_diary_bloc.dart';

@freezed
class SearchDiaryState with _$SearchDiaryState {
  const factory SearchDiaryState.initial({required List<Diary> diaries}) = _Initial;
}
