part of 'search_diary_bloc.dart';

@freezed
class SearchDiaryEvent with _$SearchDiaryEvent {
  const factory SearchDiaryEvent.search({required String query}) = _Search;
}
