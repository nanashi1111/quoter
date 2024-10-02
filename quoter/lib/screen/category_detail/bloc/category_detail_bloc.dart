import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/models/category_of_quote.dart';
import 'package:quoter/repositories/cached/quote_data.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';
part 'category_detail_bloc.freezed.dart';

class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailBloc() : super(const CategoryDetailState.initial(quotes: [], imagePath: [])) {
    on<_Started>((event, emit) async {
      String category = event.category.category ?? "";
      List<String> quotes = QuoteData.getQuotesOfCategory(category);
      quotes.shuffle(Random());

      List<String> imagePath = [];
      for (int i = 1 ; i <= quotes.length; i++ ) {
        Random random = Random();
        int imageId = 1 + random.nextInt(86);
        imagePath.add('assets/images/bg_${imageId.toString().padLeft(2, '0')}.${imageId == 40 ? 'png': 'jpg'}');
      }
      imagePath.shuffle(Random());
      for (var element in imagePath) {
        debugPrint(element);
      }
      emit(state.copyWith(quotes: quotes, imagePath: imagePath));
    });
  }
}
