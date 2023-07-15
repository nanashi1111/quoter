part of 'fetch_quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}


class FetchingQuoteState extends QuoteState {

  bool firstFetch;

  FetchingQuoteState({required this.firstFetch});

  @override
  List<Object?> get props => [firstFetch];

}

class FetchedQuoteState extends QuoteState {

  List<Quote> quotes;

  FetchedQuoteState({required this.quotes});

  @override
  List<Object?> get props => [quotes];


}
