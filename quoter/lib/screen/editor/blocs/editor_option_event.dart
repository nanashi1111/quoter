part of 'editor_option_bloc.dart';

abstract class EditorOptionEvent extends Equatable {
  const EditorOptionEvent();
}


class SelectEditorOptionEvent extends EditorOptionEvent {

  EditorOption editorOption;

  SelectEditorOptionEvent({required this.editorOption});

  @override
  List<Object?> get props => [editorOption];

}