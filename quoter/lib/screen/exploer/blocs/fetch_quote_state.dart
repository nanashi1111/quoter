part of 'fetch_quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}


class FetchingQuoteState extends QuoteState {


  FetchingQuoteState();

  @override
  List<Object?> get props => [];

}

class FetchedQuoteState extends QuoteState {

  List<Quote> quotes;

  bool loadingMore;

  FetchedQuoteState({required this.quotes, required this.loadingMore});

  @override
  List<Object?> get props => [quotes, loadingMore];


}
