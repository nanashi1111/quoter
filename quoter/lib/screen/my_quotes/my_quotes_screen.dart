import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/empty_view.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/models/quote_editor.dart';
import 'package:quoter/screen/my_quotes/bloc/my_quotes_bloc.dart';
import 'package:quoter/screen/my_quotes/my_quote_item.dart';
import 'package:quoter/utils/admob_helper.dart';

class MyQuotesScreen extends StatelessWidget {
  const MyQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "My quotes",
          style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
        ),
        centerTitle: Platform.isIOS,
        backgroundColor: darkCommonColor,
      ),
      backgroundColor: darkCommonColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BlocProvider<MyQuotesBloc>(
          create: (context) => MyQuotesBloc()..add(const MyQuotesEvent.started()),
          child: BlocBuilder<MyQuotesBloc, MyQuotesState>(
            builder: (context, state) {
              int numberOfQuotes = state.quotes.length;
              if (numberOfQuotes > 0) {
                return ListView.separated(
                  itemBuilder: (context, pos) {
                    double size = MediaQuery.of(context).size.width * 1;

                    QuoteEditor quote = state.quotes[pos];
                    return MyQuoteItem(
                      size: size,
                      content: quote,
                      callback: () {
                        // AdmobHelper.instance.showInterAds(() {
                        //   QuoteEditor quote = state.quotes[pos];
                        //   String quoteContent = jsonEncode(Quote(content: quote.content));
                        //   int patternPos = quote.backgroundPatternPos;
                        //   int imagePos = quote.backgroundImagePos;
                        //
                        // });
                      },
                    );
                  },
                  separatorBuilder: (context, pos) {
                    return verticalSpacing(10);
                  },
                  itemCount: state.quotes.length,
                );
              } else {
                return EmptyView();
              }

            },
          ),
        ),
      ),
    );
  }
}
