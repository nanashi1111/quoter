import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/screen/exploer/quotes_list.dart';
import 'package:quoter/screen/search/bloc/search_quote_bloc.dart';
import 'package:quoter/utils/admob_helper.dart';

class SearchQuoteScreen extends StatelessWidget {
  SearchQuoteScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchQuoteBloc>(
      create: (context) =>
      SearchQuoteBloc()
        ..add(const SearchQuoteEvent.query(query: "")),
      child: BlocBuilder<SearchQuoteBloc, SearchQuoteState>(
        builder: (context, state) {
          return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: HexColor("#EBEAED"), borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                onChanged: (query) {
                                  context.read<SearchQuoteBloc>().add(SearchQuoteEvent.query(query: query));
                                },
                                controller: controller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search quotes...',
                                ),
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              )),
                          horizontalSpacing(15),
                          GestureDetector(
                            child: SizedBox(
                                width: 25,
                                height: 25,
                                child: SvgPicture.asset(
                                  'assets/images/ic_clear_search_bar.svg',
                                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                  width: 25,
                                  height: 25,
                                )),
                            onTap: () {
                              context.read<SearchQuoteBloc>().add(const SearchQuoteEvent.query(query: ''));
                              controller.text = "";
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: ListView.separated(
                          itemBuilder: (context, pos) {
                            int quoteCount = state.quotes.length;
                            Quote quote = state.quotes[pos];
                            return QuoteItem(
                              pos: 1 + pos % 6,
                              content: quote,
                              callback: () {
                                AdmobHelper.instance.showInterAds(() {
                                  Map<String, String> pathParameters = <String, String>{}
                                    ..addEntries(List.of([MapEntry("quote", jsonEncode(quote)), MapEntry("backgroundPatternPos", "${1 + pos % 6}")]));
                                  context.pushNamed("editor", pathParameters: pathParameters);
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, pos) {
                            return verticalSpacing(10);
                          },
                          itemCount: state.quotes.length,
                        ),
                      ))
                ],
              ));
        },
      ),
    );
  }
}
