part of 'editor_bloc.dart';

abstract class EditorEvent extends Equatable {
  const EditorEvent();
}

class InitialEditorEvent extends EditorEvent {
  Quote quote;
  int backgroundPatternPos;
  InitialEditorEvent({required this.quote, required this.backgroundPatternPos});

  @override
  List<Object?> get props => [quote];
}

class ChangeTextEvent extends EditorEvent {

  String newText;

  ChangeTextEvent({required this.newText});

  @override
  List<Object?> get props => [newText];

}
