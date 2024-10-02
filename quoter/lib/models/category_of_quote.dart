import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_of_quote.freezed.dart';

@freezed
class CategoryOfQuote with _$CategoryOfQuote {
  const factory CategoryOfQuote({
    @JsonKey(name: "category") String? category,
    @JsonKey(name: "quote_of_category") String? quoteOfCategory,
  }) = _CategoryOfQuote;
}
