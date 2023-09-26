import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/models/editor_option.dart';
import 'package:quoter/screen/editor/blocs/editor_option_bloc.dart';

import '../blocs/editor_bloc.dart';

const int COLUMNS = 4;
const double BORDER_RADIUS = 10;

class ColorSelector extends StatelessWidget {


  const ColorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: COLUMNS, mainAxisSpacing: 0, crossAxisSpacing: 0),
        itemBuilder: (context, position) {
          if (position == 0) {
            return PickColorSelectorItem();
          } else {
            return ColorSelectorItem(
              color: textColors[position - 1],
              position: position,
              totalCount: 1 + textColors.length,
            );
          }
        },
        shrinkWrap: true,
        itemCount: 1 + textColors.length,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}

class PickColorSelectorItem extends StatelessWidget {
  PickColorSelectorItem({super.key});

  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(color: HexColor("F6F4EB"), borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(BORDER_RADIUS)
    ),
       // border: Border(
       //   top: BorderSide(width: 5)
       // )
       //border: Border.all(color: Colors.black.withOpacity(0.2))
    );
    return InkWell(
      child: Container(
        decoration: decoration,
        alignment: Alignment.center,
        child: Icon(Icons.add, size: 50, color: Colors.black.withOpacity(0.5)),

      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text('Pick a color', style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19)),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _currentSelectedColor(context),
                onColorChanged: (color) {
                  _selectedColor = color;
                },
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (_selectedColor != null) {
                      _changeColor(context, _selectedColor!);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "OK",
                      style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Color _currentSelectedColor(BuildContext context) {
    EditorOptionBloc editorOptionBloc = context.read<EditorOptionBloc>();
    EditorOptionList options = editorOptionBloc.state as EditorOptionList;
    EditorOption selectedOption = options.editorOptions.firstWhere((element) => element.selected == true);
    EditorBloc editorBloc = context.read<EditorBloc>();

    if (selectedOption.type == TYPE_SELECT_TEXT_COLOR) {
      return (editorBloc.state as EditingState).quoteEditor.textStyle.color ?? Colors.white;
    } else if (selectedOption.type == TYPE_SELECT_BACKGROUND_COLOR) {
      return (editorBloc.state as EditingState).quoteEditor.backgroundColor;
    }
    return Colors.transparent;
  }

  _changeColor(BuildContext context, Color color) {
    EditorOptionBloc editorOptionBloc = context.read<EditorOptionBloc>();
    EditorOptionList options = editorOptionBloc.state as EditorOptionList;
    EditorOption selectedOption = options.editorOptions.firstWhere((element) => element.selected == true);
    EditorBloc editorBloc = context.read<EditorBloc>();
    //Text color
    if (selectedOption.type == TYPE_SELECT_TEXT_COLOR) {
      editorBloc.add(ChangeTextColorEvent(color: color));
    } else if (selectedOption.type == TYPE_SELECT_BACKGROUND_COLOR) {
      editorBloc.add(ChangeBackgroundColorEvent(color: color));
    }
  }
}

class ColorSelectorItem extends StatelessWidget {
  Color color;

  int position;
  int totalCount;
  int itemPerRow = 3;

  ColorSelectorItem({super.key, required this.color, required this.position, required this.totalCount});

  BorderRadius _provideBorderRadius() {
    if (position == COLUMNS - 1) {
      return const BorderRadius.only(
          topRight: Radius.circular(BORDER_RADIUS)
      );
    }
    if (position == totalCount - 1) {
      return const BorderRadius.only(
          bottomRight: Radius.circular(BORDER_RADIUS)
      );
    }
    if (position == totalCount - COLUMNS) {
      return const BorderRadius.only(
          bottomLeft: Radius.circular(BORDER_RADIUS)
      );
    }
    return const BorderRadius.all(Radius.zero);
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      color: color,
      borderRadius: _provideBorderRadius(),
    );
    return InkWell(
      child: Container(
        decoration: decoration,
        alignment: Alignment.center,
      ),
      onTap: () => _changeColor(context),
    );
  }

  _changeColor(BuildContext context) {
    EditorOptionBloc editorOptionBloc = context.read<EditorOptionBloc>();
    EditorOptionList options = editorOptionBloc.state as EditorOptionList;
    EditorOption selectedOption = options.editorOptions.firstWhere((element) => element.selected == true);
    EditorBloc editorBloc = context.read<EditorBloc>();
    //Text color
    if (selectedOption.type == TYPE_SELECT_TEXT_COLOR) {
      editorBloc.add(ChangeTextColorEvent(color: color));
    } else if (selectedOption.type == TYPE_SELECT_BACKGROUND_COLOR) {
      editorBloc.add(ChangeBackgroundColorEvent(color: color));
    }
  }
}
