import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/repositories/quote_repository.dart';

part 'search_quote_event.dart';

part 'search_quote_state.dart';

part 'search_quote_bloc.freezed.dart';

class SearchQuoteBloc extends Bloc<SearchQuoteEvent, SearchQuoteState> {
  final QuoteRepository quoteRepository = getIt.get<QuoteRepository>();

  SearchQuoteBloc() : super(const SearchQuoteState.initial(quotes: [])) {
    on<_Query>((event, emit) async {
      List<Quote> result = (await quoteRepository.searchQuotes(event.query)).map((e) => Quote(content: e.content ?? "")).toList();
      emit(state.copyWith(quotes: result));
    });
  }
}
