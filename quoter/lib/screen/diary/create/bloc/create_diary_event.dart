part of 'create_diary_bloc.dart';

@freezed
class CreateDiaryEvent with _$CreateDiaryEvent {
  const factory CreateDiaryEvent.started({required Diary? diary}) = _Started;
  const factory CreateDiaryEvent.addImages({required List<XFile> images, required int pos}) = _AddImages;
  const factory CreateDiaryEvent.removeImage({required int pos}) = _RemoveImage;
  const factory CreateDiaryEvent.onPageChanged({required int pos}) = _OnPageChanged;

}
