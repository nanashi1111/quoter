part of 'editor_bloc.dart';

abstract class EditorState extends Equatable {

}

class InitEditorState extends EditorState {
  InitEditorState();

  @override
  List<Object?> get props => [];

}

class EditingState extends EditorState {
  QuoteEditor quoteEditor;
  EditingState({required this.quoteEditor});

  @override
  List<Object?> get props => [quoteEditor];
}

