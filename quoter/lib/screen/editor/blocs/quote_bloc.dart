import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quoter/models/quote_editor.dart';

import '../../../common/dependency_injection.dart';
import '../../../repositories/quote_repository.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {

  QuoteRepository repository = getIt.get<QuoteRepository>();

  QuoteBloc() : super(QuoteStateInit()) {
    on<SaveQuoteEvent>((event, emit) async {
      await repository.saveQuote(event.quoteEditor);
      emit(QuoteStateSaved(savedTime: DateTime.now().millisecondsSinceEpoch));
    });
  }
}
