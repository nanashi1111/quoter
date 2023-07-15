part of 'fetch_quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}

class FetchingQuoteState extends QuoteState {
  @override
  List<Object?> get props => [];

}

class FetchedQuoteState extends QuoteState {

  List<Quote> quotes;

  FetchedQuoteState({required this.quotes});

  @override
  List<Object?> get props => [quotes];


}
