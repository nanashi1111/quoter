import 'package:freezed_annotation/freezed_annotation.dart';
part 'diary_card.freezed.dart';

@freezed
class DiaryCard with _$DiaryCard {
  const factory DiaryCard({
    @JsonKey(name: "diary_count")
    required int diary_count,
    @JsonKey(name: "month")
    required int month,
    @JsonKey(name: "year")
    required int year,
    @JsonKey(name: "image")
    required String image,
  }) = _DiaryCard;
}
