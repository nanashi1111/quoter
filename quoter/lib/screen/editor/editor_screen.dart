import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';

class EditorScreen extends StatelessWidget {
  final Quote quote;
  final int backgroundPatternPos;

  const EditorScreen({super.key, required this.quote, required this.backgroundPatternPos});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc()..add(InitialEditorEvent(quote: quote, backgroundPatternPos: backgroundPatternPos)),
      child: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Center(
                      child: Text(
                        "Back",
                        style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w900, color: Colors.black, fontSize: 17),
                      ),
                    ),
                  )),
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w900, color: Colors.blue, fontSize: 17),
                        ),
                      ),
                    ))
              ],
            ),
            body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create your quote",
                        style: TextStyle(color: Color.fromRGBO(18, 34, 59, 1), fontFamily: 'Lato', fontWeight: FontWeight.w900, fontSize: 36),
                      ),
                      verticalSpacing(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_provideEditorUI(state)],
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget _provideEditorUI(EditorState state) {
    if (state is EditingState) {
      return EditorPreview(quoteEditor: state.quoteEditor);
    } else {
      return Container();
    }
  }
}

class EditorPreview extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();
  final QuoteEditor quoteEditor;

  EditorPreview({super.key, required this.quoteEditor});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.9;
    _controller.text = quoteEditor.content;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    return Stack(
      children: [
        Image(
          image: AssetImage(
            _provideImagePath(),
          ),
          fit: BoxFit.cover,
          width: size,
          height: size,
        ),
        Container(
          width: size,
          height: size,
          color: Colors.black.withOpacity(0.5),
        ),
        Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          width: size,
          height: size,
          padding: const EdgeInsets.all(20),
          child: TextField(
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
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

  String _provideImagePath() {
    return "assets/images/pattern_${quoteEditor.backgroundPatternPos}.jpg";
  }
}
