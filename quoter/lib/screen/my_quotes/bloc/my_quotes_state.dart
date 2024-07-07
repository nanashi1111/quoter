part of 'my_quotes_bloc.dart';

@freezed
class MyQuotesState with _$MyQuotesState {
  const factory MyQuotesState.initial({required List<QuoteEditor> quotes}) = _Initial;
}
