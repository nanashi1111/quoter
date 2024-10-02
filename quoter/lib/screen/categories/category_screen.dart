import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/screen/categories/bloc/category_bloc.dart';
import 'package:quoter/screen/categories/components/quote_category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
          'Categories',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
        ),
        centerTitle: Platform.isIOS,
        backgroundColor: darkCommonColor,
      ),
      body: BlocProvider<CategoryBloc>(
        create: (_) => CategoryBloc()..add(const CategoryEvent.started()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return Container(
              color: darkCommonColor,
              child: ListView.separated(
                  itemBuilder: (context, pos) {
                    return QuoteCategoryItem(category: state.categories[pos], onClick: (category) {
                      context.push('/category_detail', extra: state.categories[pos]);
                    });
                  },
                  separatorBuilder: (context, pos) {
                    return SizedBox(
                      height: 2,
                    );
                  },
                  itemCount: state.categories.length),
            );
          },
        ),
      ),
    );
  }
}
