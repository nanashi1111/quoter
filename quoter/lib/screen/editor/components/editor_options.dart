import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/editor_option.dart';
import 'package:quoter/screen/editor/blocs/editor_option_bloc.dart';
import 'package:quoter/screen/editor/components/color_selector.dart';
import 'package:quoter/screen/editor/components/font_selector.dart';
import 'package:quoter/screen/editor/components/pattern_selector.dart';
import 'package:quoter/screen/editor/components/text_size_selector.dart';
import 'package:quoter/screen/editor/components/wallpaper_selector.dart';

class EditorOptions extends StatelessWidget {
  const EditorOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorOptionBloc, EditorOptionState>(
      builder: (context, state) {
        return ListView(shrinkWrap: true, children: [
          _provideEditorOptions(state as EditorOptionList),
          verticalSpacing(10),
          _provideSelector(state as EditorOptionList)
        ]);
      },
    );
  }

  Widget _provideEditorOptions(EditorOptionList state) {
    return SizedBox(
      height: 65,
      child: Padding(padding: EdgeInsets.only(left: 5, right: 5), child:  ListView.separated(
          itemBuilder: (context, pos) {
            return  EditorOptionItem(
              editorOption: state.editorOptions[pos],
            );
          },
          separatorBuilder: (context, pos) {
            return verticalSpacing(10);
          },
          itemCount: state.editorOptions.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true),)
    );
  }

  Widget _provideSelector(EditorOptionList state) {
    switch (state.editorOptions.firstWhere((element) => element.selected == true).type) {
      case TYPE_SELECT_FONT:
        return FontSelector();
      case TYPE_SELECT_TEXT_COLOR:
        return ColorSelector();
      case TYPE_SELECT_TEXT_SIZE:
        return TextSizeSelector();
      case TYPE_SELECT_BACKGROUND_COLOR:
        return ColorSelector();
      case TYPE_SELECT_BACKGROUND_WALLPAPER:
        return WallpaperSelector();
      case TYPE_SELECT_BACKGROUND_PATTERN:
        return PatternSelector();
      default:
        return Text("Unknown");
    }
  }
}

class EditorOptionItem extends StatelessWidget {
  EditorOption editorOption;

  EditorOptionItem({super.key, required this.editorOption});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = HexColor("#FFFFCC");
    Color unselectedColor = selectedColor.withOpacity(0.5);
    if (editorOption.selected == true) {
      
      return Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: selectedColor, width: 1.5)),
            child: Text(
              editorOption.title ?? "",
              style: GoogleFonts.montserrat(color: selectedColor, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.only(left: 5, top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selectedColor,
            ),
            child: Icon(
              Icons.check,
              color: darkCommonColor,
              size: 10,
            ),
          )
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {
          context.read<EditorOptionBloc>().add(SelectEditorOptionEvent(editorOption: editorOption));
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: unselectedColor, width: 1.5)),
          child: Text(
            editorOption.title ?? "",
            style: GoogleFonts.montserrat(color: unselectedColor, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
