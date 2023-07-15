import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/category.dart';
import 'package:quoter/repositories/entities/category.dart';
import 'package:quoter/repositories/quote_repository.dart';

part 'fetch_tab_event.dart';

part 'fetch_tab_state.dart';

class FetchTabBloc extends Bloc<TabEvent, TabState> {

  QuoteRepository repository = getIt.get<QuoteRepository>();

  FetchTabBloc() : super(FetchingTabs()) {
    on<TabEvent>(mapEventToState);
  }

  Future mapEventToState(TabEvent event, Emitter emitter) async {
    print("Received event: $event");
    if (event is FetchTabEvent) {
      emit(FetchingTabs());
      List<QuoteCategoryEntity> entities = await repository.getCatgories();
      List<QuoteCategory> categories = List.of([]);
      for (int i = 0; i < entities.length; i++) {
        categories.add(QuoteCategory(title: entities[i].name.toUpperCase(), selected: i == 0));
      }
      emit(FetchededTabState(categories: categories));
    } else if (event is SelectTabEvent && state is FetchededTabState) {
      List<QuoteCategory> categories = (state as FetchededTabState).categories.map((e) => QuoteCategory(title: e.title.toUpperCase(), selected: e.selected)).toList();
      for (int i = 0; i < categories.length; i++) {
        categories[i].selected = i == event.position;
      }
      emit(FetchededTabState(categories: categories));
    }
  }
}
