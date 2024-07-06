import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';
import 'package:quoter/screen/editor/blocs/editor_option_bloc.dart';

class TextSizeSelector extends StatelessWidget {
  const TextSizeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(builder: (context, state) {
      return  Center(child: Padding(padding: EdgeInsets.all(20), child: Row(
        children: [
          Text("A", style: TextStyle(fontSize: 15),),
          SizedBox(width: 20,),
          Expanded(child: CupertinoSlider(
            min: 0.0,
            max: 100.0,
            value: _fontSize(state),
            onChanged: (value) {
              TextStyle currentTextStyle = (state as EditingState).quoteEditor.textStyle.copyWith(fontSize: value);
              String fontName = state.quoteEditor.fontName;
              context.read<EditorBloc>().add(ChangeFontEvent(textStyle: currentTextStyle, fontName: fontName));
            },
          ),),
          SizedBox(width: 20,),
          Text("A", style: TextStyle(fontSize: 40),),
        ],
      ),));
    });

  }

  double _fontSize(EditorState state) {
    if (state is EditingState == false) {
      return 0;
    }
    return (state as EditingState).quoteEditor.textStyle.fontSize ?? 0;
  }
}