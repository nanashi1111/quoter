import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';
import 'package:quoter/screen/editor/blocs/editor_option_bloc.dart';
import 'package:quoter/screen/editor/blocs/quote_bloc.dart';
import 'package:quoter/screen/editor/components/editor_options.dart';
import 'components/editor_preview.dart';

class EditorScreen extends StatelessWidget {
  final Quote quote;
  final int backgroundPatternPos;

  const EditorScreen({super.key, required this.quote, required this.backgroundPatternPos});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => EditorBloc()..add(InitialEditorEvent(quote: quote, backgroundPatternPos: backgroundPatternPos))),
          BlocProvider(create: (_) => EditorOptionBloc()),
          BlocProvider(create: (_) => QuoteBloc())
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "Back",
                    style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                )),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              BlocBuilder<QuoteBloc, QuoteState>(
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () {
                        EditingState state = context.read<EditorBloc>().state as EditingState;
                        QuoteEditor quoteEditor = state.quoteEditor;
                        context.read<QuoteBloc>().add(SaveQuoteEvent(quoteEditor: quoteEditor));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "Done",
                          style: GoogleFonts.montserrat(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ));
                },
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create your quote",
                      style: GoogleFonts.montserrat(color: const Color.fromRGBO(18, 34, 59, 1), fontWeight: FontWeight.w600, fontSize: 36),
                    ),
                    verticalSpacing(15),
                    BlocBuilder<EditorBloc, EditorState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_provideEditorUI(state)],
                        );
                      },
                    )
                  ],
                ),
              ),
              Expanded(child: BlocBuilder<EditorOptionBloc, EditorOptionState>(
                builder: (context, state) {
                  return const EditorOptions();
                },
              ))
            ],
          ),
        ));
  }

  Widget _provideEditorUI(EditorState state) {
    if (state is EditingState) {
      return EditorPreview(quoteEditor: state.quoteEditor);
    } else {
      return Container();
    }
  }
}
