part of 'search_quote_bloc.dart';

@freezed
class SearchQuoteEvent with _$SearchQuoteEvent {
  const factory SearchQuoteEvent.query({required String query}) = _Query;
}
