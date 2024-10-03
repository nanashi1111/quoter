import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/utils/constants.dart';

import '../../../models/quote_editor.dart';
import '../blocs/editor_bloc.dart';

class EditorPreview extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final QuoteEditor quoteEditor;

  EditorPreview({super.key, required this.quoteEditor});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    _controller.text = quoteEditor.content;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    double fontSize = (quoteEditor.textStyle.fontSize == 0 ? 22 : quoteEditor.textStyle.fontSize)?.toDouble() ?? 0;
    return Stack(
      children: [
        _providePatternBackground(size),
        _provideColorBackground(size),
        _provideImageBackground(size),
        Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          width: size,
          height: size,
          padding: const EdgeInsets.all(1),
          child: TextField(
            style: quoteEditor.textStyle.copyWith(fontSize: fontSize, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(hintText: 'Input here', hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)), border: InputBorder.none),
            controller: _controller,
            onChanged: (text) {
              context.read<EditorBloc>().add(ChangeTextEvent(newText: text));
            },
          ),
        )
      ],
    );
  }

  Widget _provideColorBackground(double size) {
    return Container(
      width: size,
      height: size,
      color: quoteEditor.backgroundColor,
    );
  }

  Widget _providePatternBackground(double size) {
    if (quoteEditor.backgroundPatternPos > 0) {
      return Image(
        image: AssetImage(
          "assets/images/pattern_${quoteEditor.backgroundPatternPos}.jpg",
        ),
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    }
    return SizedBox(
      width: 1,
      height: 1,
    );
  }
  Widget _provideImageBackground(double size) {
    if (quoteEditor.backgroundImagePos > 0) {
      String path = "assets/images/bg_${quoteEditor.backgroundImagePos.toString().padLeft(2, '0')}.jpg";
      return SizedBox(
        width: size, height: size,
        child: Stack(
          children: [
            Image(
              image: AssetImage(
                path,
              ),
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
            Container(
              width: size, height: size, color: Colors.black.withOpacity(BLACK_LAYER_ALPHA),
            )
          ],
        ),
      );
    }
    return SizedBox(
      width: 1,
      height: 1,
    );
  }
}
