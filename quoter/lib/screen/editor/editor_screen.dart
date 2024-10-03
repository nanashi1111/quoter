import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/toast.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';
import 'package:quoter/screen/editor/blocs/editor_option_bloc.dart';
import 'package:quoter/screen/editor/blocs/quote_bloc.dart';
import 'package:quoter/screen/editor/components/editor_options.dart';
import 'package:quoter/utils/admob_helper.dart';
import 'components/editor_preview.dart';

class EditorScreen extends StatelessWidget {
  final Quote quote;
  final int backgroundImagePos;

  const EditorScreen({super.key, required this.quote, required this.backgroundImagePos});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => EditorBloc()..add(InitialEditorEvent(quote: quote, backgroundImagePos: backgroundImagePos))),
          BlocProvider(create: (_) => EditorOptionBloc()),
          BlocProvider(create: (_) => QuoteBloc())
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                child: SvgPicture.asset(
                  'assets/images/ic_back.svg',
                  color: Colors.white,
                  width: 25,
                  height: 25,
                ),
              ),
              onTap: () {
                context.pop();
              },
            ),
            title: Text(
              'Categories',
              style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
            ),
            centerTitle: Platform.isIOS,
            backgroundColor: darkCommonColor,
            actions: [
              BlocBuilder<QuoteBloc, QuoteState>(
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () {
                        AdmobHelper.instance.showInterAds(() {
                          EditingState state = context.read<EditorBloc>().state as EditingState;
                          QuoteEditor quoteEditor = state.quoteEditor;
                          context.read<QuoteBloc>().add(SaveQuoteEvent(quoteEditor: quoteEditor));
                          showToast(context, "Your quote is saved");
                          context.pop();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "Done",
                          style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ));
                },
              )
            ],
          ),

          resizeToAvoidBottomInset: false,
          backgroundColor: darkCommonColor,
          body: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
