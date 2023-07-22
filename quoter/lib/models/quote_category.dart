import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_category.freezed.dart';
part 'quote_category.g.dart';

@freezed
class QuoteCategory with _$QuoteCategory {
  const factory QuoteCategory({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'selected') bool? selected,
  }) = _QuoteCategory;

  factory QuoteCategory.fromJson(Map<String, Object?> json) => _$QuoteCategoryFromJson(json);
}

