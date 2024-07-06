part of 'search_quote_bloc.dart';

@freezed
class SearchQuoteState with _$SearchQuoteState {
  const factory SearchQuoteState.initial({required List<Quote> quotes}) = _Initial;
}
