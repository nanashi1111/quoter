import 'package:freezed_annotation/freezed_annotation.dart';
part 'diary.freezed.dart';

@freezed
class Diary with _$Diary {
  const factory Diary({
    @JsonKey(name: "id")
    required int id,
    @JsonKey(name: "day")
    required int day,
    @JsonKey(name: "month")
    required int month,
    @JsonKey(name: "year")
    required int year,
    @JsonKey(name: "content")
    required String content,
    @JsonKey(name: "title")
    required String title,
    @JsonKey(name: "images")
    required String images,
  }) = _Diary;
}
