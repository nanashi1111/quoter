import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';

const int COLUMNS = 4;
const double BORDER_RADIUS = 10;

class FontSelector extends StatelessWidget {
  const FontSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: COLUMNS, mainAxisSpacing: 0, crossAxisSpacing: 0),
        itemBuilder: (context, position) {
          return FontSelectorItem(
            style: textStyles[position],
            fontName: fontNames[position],
          );
        },
        shrinkWrap: true,
        itemCount: textStyles.length,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}

class FontSelectorItem extends StatelessWidget {
  TextStyle style;
  String fontName;

  FontSelectorItem({super.key, required this.style, required this.fontName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "ABC",
          style: style.copyWith(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      onTap: () {

        context.read<EditorBloc>().add(ChangeFontEvent(textStyle: style.copyWith(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600), fontName: fontName));
      },
    );
  }
}
