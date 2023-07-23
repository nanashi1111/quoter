import 'package:freezed_annotation/freezed_annotation.dart';

part 'editor_option.freezed.dart';
part 'editor_option.g.dart';

const int TYPE_SELECT_FONT = 0;
const int TYPE_SELECT_TEXT_COLOR = 1;
const int TYPE_SELECT_TEXT_SIZE = 2;
const int TYPE_SELECT_TOP_LAYER_COLOR = 3;
const int TYPE_SELECT_BACKGROUND_COLOR = 4;
const int TYPE_SELECT_BACKGROUND_WALLPAPER = 5;
const int TYPE_SELECT_BACKGROUND_PATTERN = 6;

@freezed
class EditorOption with _$EditorOption {
  const factory EditorOption({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'selected') bool? selected,
  }) = _EditorOption;

  factory EditorOption.fromJson(Map<String, Object?> json) => _$EditorOptionFromJson(json);
}

