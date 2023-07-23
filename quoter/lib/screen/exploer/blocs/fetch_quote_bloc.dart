import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/repositories/entities/quote_entity.dart';
import 'package:quoter/repositories/quote_repository.dart';

part 'fetch_quote_event.dart';
part 'fetch_quote_state.dart';

class FetchQuoteBloc extends Bloc<FetchQuoteEvent, QuoteState> {

  QuoteRepository repository = getIt.get<QuoteRepository>();

  FetchQuoteBloc() : super(FetchingQuoteState())  {
    on<FetchQuoteEvent>((event, emit) async {
      if (state is FetchedQuoteState) {
        FetchedQuoteState newState = FetchedQuoteState(quotes: (state as FetchedQuoteState).quotes, loadingMore: true);
        emit(newState);
      } else {
        emit(FetchingQuoteState());
      }
      List<QuoteEntity> quoteEntities = await repository.getQuotes(event.category);
      //Fetched
      List<Quote> quotes = List.of([], growable: true);
      if (state is FetchedQuoteState) {
        quotes.addAll((state as FetchedQuoteState).quotes);
      }
      quotes.addAll(quoteEntities.map((e) => Quote(content: e.content ?? "")).toList());
      emit(FetchedQuoteState(quotes: quotes, loadingMore: false));
    });
  }
  
}
