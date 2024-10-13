part of 'diary_home_bloc.dart';

@freezed
class DiaryHomeEvent with _$DiaryHomeEvent {
  const factory DiaryHomeEvent.getCardsOfYear({required int? year}) = _GetCardsOfYear;
  const factory DiaryHomeEvent.switchViewMode() = _SwitchViewMode;
  const factory DiaryHomeEvent.refresh() = _Refresh;
  const factory DiaryHomeEvent.updateCardDesign({required DiaryCard card, required String design}) = _UpdateCardDesign;
}
