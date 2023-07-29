import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';

import '../../../common/colors.dart';

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
                backgroundColor: currentQuoteEditor.backgroundColor,
                textStyle: currentQuoteEditor.textStyle));
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
                backgroundColor: currentQuoteEditor.backgroundColor,
                textStyle: currentQuoteEditor.textStyle));
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
                backgroundColor: event.color,
                textStyle: currentQuoteEditor.textStyle));
        print("Emit_NewState: ${newState.hashCode}: $newState from bloc ${hashCode}");
        emit(newState);
      }
    });

    on<ChangeFontEvent>((event, emitter) {
      QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
      EditingState newState = EditingState(
          quoteEditor: currentQuoteEditor.copy(
              content: currentQuoteEditor.content,
              textColor: currentQuoteEditor.textColor,
              backgroundPatternPos: currentQuoteEditor.backgroundPatternPos,
              backgroundColor: currentQuoteEditor.backgroundColor,
              textStyle: event.textStyle));
      print("Emit_NewState: ${newState.hashCode}: $newState from bloc ${hashCode}");
      emit(newState);
    });

    on<ChangePatternEvent>((event, emitter) {
      QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
      EditingState newState = EditingState(
          quoteEditor: currentQuoteEditor.copy(
              content: currentQuoteEditor.content,
              textColor: currentQuoteEditor.textColor,
              backgroundPatternPos: event.position,
              backgroundColor: currentQuoteEditor.backgroundColor,
              textStyle: currentQuoteEditor.textStyle));
      print("Emit_NewState: ${newState.hashCode}: $newState from bloc ${hashCode}");
      emit(newState);
    });
  }
}
