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

class ChangePatternEvent extends EditorEvent {
  int position;
  ChangePatternEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

class ChangeTextColorEvent extends EditorEvent {
  Color color;

  ChangeTextColorEvent({required this.color});

  @override
  List<Object?> get props => [color];
}

class ChangeBackgroundColorEvent extends EditorEvent {
  Color color;

  ChangeBackgroundColorEvent({required this.color});

  @override
  List<Object?> get props => [color];
}

class ChangeFontEvent extends EditorEvent {

  var textStyle = GoogleFonts.montserrat(fontWeight: FontWeight.w600);

  ChangeFontEvent({required this.textStyle});

  @override
  List<Object?> get props => [textStyle];
}
