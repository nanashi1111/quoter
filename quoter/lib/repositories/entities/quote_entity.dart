import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_entity.freezed.dart';
part 'quote_entity.g.dart';

@freezed
class QuoteEntity with _$QuoteEntity {
  const factory QuoteEntity({
    @JsonKey(name: '_id') String? Id,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'author') String? author,
    @JsonKey(name: 'tags') List<String>? tags,
    @JsonKey(name: 'authorSlug') String? authorSlug,
    @JsonKey(name: 'length') int? length,
    @JsonKey(name: 'dateAdded') String? dateAdded,
    @JsonKey(name: 'dateModified') String? dateModified,
  }) = _QuoteEntity;

  factory QuoteEntity.fromJson(Map<String, Object?> json) => _$QuoteEntityFromJson(json);
}

