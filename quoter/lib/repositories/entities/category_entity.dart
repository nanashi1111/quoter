import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    @JsonKey(name: '_id') String? Id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'quoteCount') int? quoteCount,
    @JsonKey(name: 'dateAdded') String? dateAdded,
    @JsonKey(name: 'dateModified') String? dateModified,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, Object?> json) => _$CategoryEntityFromJson(json);
}

