import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/models/category_of_quote.dart';
import 'package:quoter/screen/category_detail/bloc/category_detail_bloc.dart';
import 'package:quoter/screen/category_detail/components/quote_item.dart';

class CategoryDetailScreen extends StatelessWidget {
  final CategoryOfQuote category;

  const CategoryDetailScreen({super.key, required this.category});

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
          category.category ?? "",
          style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
        ),
        centerTitle: Platform.isIOS,
        backgroundColor: darkCommonColor,
      ),
      body: BlocProvider<CategoryDetailBloc>(
        create: (_) => CategoryDetailBloc()..add(CategoryDetailEvent.started(category: category)),
        child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
          builder: (context, state) {
            return Container(
              color: darkCommonColor,
              child: ListView.separated(
                  itemBuilder: (context, pos) {
                    return QuoteItem(quote: state.quotes[pos], onClick: (quote, pos) {
                      // Map<String, String> pathParameters = <String, String>{}
                      //   ..addEntries(List.of([MapEntry("quote", jsonEncode({'quote':quote})), MapEntry("backgroundImagePos", "${pos}")]));
                      // context.pushNamed("editor", pathParameters: pathParameters);
                      context.push('/editor', extra: { 'quote':  quote, 'backgroundImagePos': pos});
                    }, imagePos: state.imagePositions[pos]);
                  },
                  separatorBuilder: (context, pos) {
                    return const SizedBox(
                      height: 2,
                    );
                  },
                  itemCount: state.quotes.length),
            );
          },
        ),
      ),
    );
  }
}
