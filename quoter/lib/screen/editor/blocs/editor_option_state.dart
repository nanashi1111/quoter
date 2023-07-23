part of 'editor_option_bloc.dart';

abstract class EditorOptionState extends Equatable {
  const EditorOptionState();
}

class EditorOptionList extends EditorOptionState {

  List<EditorOption> editorOptions;

  EditorOptionList({required this.editorOptions});

  @override
  List<Object?> get props => [editorOptions];
}
