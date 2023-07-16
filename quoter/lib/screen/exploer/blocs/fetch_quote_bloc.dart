import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/repositories/entities/quote.dart';
import 'package:quoter/repositories/quote_repository.dart';

part 'fetch_quote_event.dart';
part 'fetch_quote_state.dart';

class FetchQuoteBloc extends Bloc<FetchQuoteEvent, QuoteState> {

  QuoteRepository repository = getIt.get<QuoteRepository>();

  FetchQuoteBloc() : super(FetchingQuoteState())  {
    print("Init FetchQuoteBloc bloc");
    on<FetchQuoteEvent>((event, emit) async {
      _fetchQuotes(event);
    });

    // Future.delayed(const Duration(milliseconds: 100), (){
    //   emit(FetchingQuoteState(firstFetch: true));
    // });

  }
  
  _fetchQuotes(FetchQuoteEvent event) async {
    emit(FetchingQuoteState());
    List<QuoteEntity> quoteEntities = await repository.getQuotes(event.category);
    List<Quote> quotes = quoteEntities.map((e) => Quote(content: e.content)).toList();
    emit(FetchedQuoteState(quotes: quotes));
  }
}
