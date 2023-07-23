import 'dart:async';
import 'dart:ui';

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
        EditingState newState = EditingState(
            quoteEditor: currentQuoteEditor.copy(
                content: event.newText,
                textColor: currentQuoteEditor.textColor,
                backgroundPatternPos: currentQuoteEditor.backgroundPatternPos,
                backgroundColor: currentQuoteEditor.backgroundColor));
        print("Emit_NewState: ${newState.hashCode}: $newState from bloc ${hashCode}");
        emit(newState);
      }
    });

    on<ChangeTextColorEvent>((event, emit) async {
      if (state is EditingState) {
        QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
        EditingState newState = EditingState(
            quoteEditor: currentQuoteEditor.copy(
                content: currentQuoteEditor.content,
                textColor: event.color,
                backgroundPatternPos: currentQuoteEditor.backgroundPatternPos,
                backgroundColor: currentQuoteEditor.backgroundColor));
        print("Emit_NewState: ${newState.hashCode}: $newState from bloc ${hashCode}");
        emit(newState);
      }
    });


    on<ChangeBackgroundColorEvent>((event, emit) async {
      if (state is EditingState) {
        QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
        EditingState newState = EditingState(
            quoteEditor: currentQuoteEditor.copy(
                content: currentQuoteEditor.content,
                textColor: currentQuoteEditor.textColor,
                backgroundPatternPos: currentQuoteEditor.backgroundPatternPos,
                backgroundColor: event.color));
        print("Emit_NewState: ${newState.hashCode}: $newState from bloc ${hashCode}");
        emit(newState);
      }
    });
  }
}
