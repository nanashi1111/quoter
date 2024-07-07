import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/repositories/quote_repository.dart';

part 'my_quotes_event.dart';
part 'my_quotes_state.dart';
part 'my_quotes_bloc.freezed.dart';

class MyQuotesBloc extends Bloc<MyQuotesEvent, MyQuotesState> {

  final QuoteRepository quoteRepository = getIt.get<QuoteRepository>();

  MyQuotesBloc() : super(const MyQuotesState.initial(quotes: []))  {
    on<_Started>((event, emit) async {
      List<QuoteEditor> quotes = await quoteRepository.getMyQuotes();
      emit(state.copyWith(quotes: quotes));
    });
  }
}
