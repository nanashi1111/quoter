import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:quoter/models/category.dart';

part 'fetch_tab_event.dart';

part 'fetch_tab_state.dart';

class FetchTabBloc extends Bloc<TabEvent, TabState> {
  FetchTabBloc() : super(FetchingTabs()) {
    on<TabEvent>(mapEventToState);
  }

  Future mapEventToState(TabEvent event, Emitter emitter) async {
    print("Received event: $event");
    if (event is FetchTabEvent) {
      emit(FetchingTabs());
      Future.delayed(Duration(milliseconds: 500), () {
        List<QuoteCategory> categories = List.of([]);
        for (int i = 0; i < 10; i++) {
          categories.add(QuoteCategory(title: "TAB $i", selected: i == 0));
        }
        emit(FetchededTabState(categories: categories));
      });
    } else if (event is SelectTabEvent && state is FetchededTabState) {
      List<QuoteCategory> categories = (state as FetchededTabState).categories.map((e) => QuoteCategory(title: e.title, selected: e.selected)).toList();
      for (int i = 0; i < categories.length; i++) {
        categories[i].selected = i == event.position;
      }
      emit(FetchededTabState(categories: categories));
    }
  }
}
