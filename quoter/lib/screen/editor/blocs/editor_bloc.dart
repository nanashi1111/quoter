import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(InitEditorState()) {
    on<InitialEditorEvent>((event, emit) async {
      Quote quote = event.quote;
      QuoteEditor quoteEditor = QuoteEditor();
      quoteEditor.content = quote.content ?? "";
      quoteEditor.backgroundPatternPos = event.backgroundPatternPos;
      emit(EditingState(quoteEditor: quoteEditor));
    });

    on<ChangeTextEvent>((event, emit) async {
      if (state is EditingState) {
        QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
        // QuoteEditor quoteEditor = QuoteEditor();
        // quoteEditor.content = event.newText;
        // quoteEditor.backgroundPatternPos = currentQuoteEditor.backgroundPatternPos;
        emit(EditingState(quoteEditor: currentQuoteEditor.copy(content: event.newText, backgroundPatternPos: currentQuoteEditor.backgroundPatternPos)));
        //emit(InitEditorState());
      }
    });
  }
}
