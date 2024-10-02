import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/models/category_of_quote.dart';
import 'package:quoter/repositories/cached/quote_data.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState.initial(categories: [])) {
    on<_Started>((event, emit) async {
      List<CategoryOfQuote> categories = QuoteData.categories.map((e) {
        String categoryName = e;
        String quote = QuoteData.getQuoteOfCategory(categoryName);
        return CategoryOfQuote(category: categoryName, quoteOfCategory: quote);
      }).toList();
      emit(state.copyWith(categories: categories));
    });
  }
}
