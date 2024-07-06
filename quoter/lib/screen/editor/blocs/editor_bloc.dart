import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(InitEditorState()) {
    on<InitialEditorEvent>((event, emit) async {
      Quote quote = event.quote;
      QuoteEditor quoteEditor = QuoteEditor(
          id: DateTime.now().millisecondsSinceEpoch,
          content: quote.content ?? "",
          backgroundPatternPos: event.backgroundPatternPos,
          backgroundImagePos: 0,
          textStyle: defaultTextStyle(),
          fontName: defaultFontName());
      emit(EditingState(quoteEditor: quoteEditor));
    });

    on<ChangeTextEvent>((event, emit) async {
      if (state is EditingState) {
        QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
        EditingState newState = EditingState(quoteEditor: currentQuoteEditor.copyWith(content: event.newText));
        emit(newState);
      }
    });

    on<ChangeTextColorEvent>((event, emit) async {
      if (state is EditingState) {
        QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
        EditingState newState = EditingState(quoteEditor: currentQuoteEditor.copyWith(textStyle: currentQuoteEditor.textStyle.copyWith(color: event.color)));
        emit(newState);
      }
    });

    on<ChangeBackgroundColorEvent>((event, emit) async {
      if (state is EditingState) {
        QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
        debugPrint("SelectedColor: ${event.color.toHexString()}");
        EditingState newState = EditingState(quoteEditor: currentQuoteEditor.copyWith(backgroundColor: event.color, backgroundImagePos: 0, backgroundPatternPos: 0));
        emit(newState);
      }
    });

    on<ChangeFontEvent>((event, emitter) {
      QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
      EditingState newState =
          EditingState(quoteEditor: currentQuoteEditor.copyWith(textStyle: event.textStyle.copyWith(color: currentQuoteEditor.textStyle.color), fontName: event.fontName));
      emit(newState);
    });

    on<ChangePatternEvent>((event, emitter) {
      QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
      EditingState newState =
          EditingState(quoteEditor: currentQuoteEditor.copyWith(backgroundPatternPos: event.position, backgroundColor: Colors.transparent, backgroundImagePos: 0));
      emit(newState);
    });

    on<ChangeBackgroundImageEvent>((event, emitter) {
      QuoteEditor currentQuoteEditor = (state as EditingState).quoteEditor;
      EditingState newState =
          EditingState(quoteEditor: currentQuoteEditor.copyWith(backgroundImagePos: event.position, backgroundColor: Colors.transparent, backgroundPatternPos: 0));
      emit(newState);
    });
  }
}
