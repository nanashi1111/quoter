import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
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
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          "My quotes",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  'assets/images/ic_back.svg',
                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  width: 45,
                  height: 45,
                ),
              ));
        }),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BlocProvider<MyQuotesBloc>(
          create: (context) => MyQuotesBloc()..add(const MyQuotesEvent.started()),
          child: BlocBuilder<MyQuotesBloc, MyQuotesState>(
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, pos) {
                  double size = MediaQuery.of(context).size.width * 0.9;

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
            },
          ),
        ),
      ),
    );
  }
}
