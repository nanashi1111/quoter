import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

@freezed
class Quote with _$Quote {
  const factory Quote({
    @JsonKey(name: 'content') String? content,
  }) = _Quote;

  factory Quote.fromJson(Map<String, Object?> json) => _$QuoteFromJson(json);

  factory Quote.fromJsonString(String json) {
    return Quote.fromJson(jsonDecode(json));
  }
}

