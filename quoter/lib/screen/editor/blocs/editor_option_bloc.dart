import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/editor_option.dart';

part 'editor_option_event.dart';

part 'editor_option_state.dart';

class EditorOptionBloc extends Bloc<EditorOptionEvent, EditorOptionState> {
  EditorOptionBloc()
      : super(EditorOptionList(
            editorOptions: List.of([
          const EditorOption(title: "Background pattern", type: TYPE_SELECT_BACKGROUND_PATTERN, selected: true),
          const EditorOption(title: "Font family", type: TYPE_SELECT_FONT, selected: false),
          const EditorOption(title: "Text color", type: TYPE_SELECT_TEXT_COLOR, selected: false),
          const EditorOption(title: "Text size", type: TYPE_SELECT_TEXT_SIZE, selected: false),
          const EditorOption(title: "Top layer color", type: TYPE_SELECT_TOP_LAYER_COLOR, selected: false),
          const EditorOption(title: "Background color", type: TYPE_SELECT_BACKGROUND_COLOR, selected: false),
          const EditorOption(title: "Background wallpaper", type: TYPE_SELECT_BACKGROUND_WALLPAPER, selected: false),
        ]))) {
    on<SelectEditorOptionEvent>((event, emit) async {
      List<EditorOption> currentOptions = (state as EditorOptionList).editorOptions;
      List<EditorOption> newOptions = List.of([]);
      for (var element in currentOptions) {
        newOptions.add(element.copyWith(selected: element.type == event.editorOption.type));
      }
      emit(EditorOptionList(editorOptions: newOptions));
    });
  }
}
