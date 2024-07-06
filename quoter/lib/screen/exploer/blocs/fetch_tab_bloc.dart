import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/models/quote_category.dart';
import 'package:quoter/repositories/quote_repository.dart';

part 'fetch_tab_event.dart';
part 'fetch_tab_state.dart';

class FetchTabBloc extends Bloc<TabEvent, TabState> {

  QuoteRepository repository = getIt.get<QuoteRepository>();

  FetchTabBloc() : super(FetchingTabs()) {

    on<FetchTabEvent>((event, emitter) async {
      emit(FetchingTabs());
      List<QuoteCategory> categories = (await repository.getCatgories())
          //.where((element) => element.quoteCount != null && element.quoteCount! > 20)
          .map((e) => QuoteCategory(title: e.name?.toUpperCase() ?? "", selected: false))
          .toList();
      if (categories.isNotEmpty) {
        QuoteCategory updated = categories[0].copyWith(selected: true);
        categories[0] = updated;
      }
      emit(FetchededTabState(categories: categories));
    });

    on<SelectTabEvent>((event, emitter) async {
      if (state is FetchededTabState) {
        List<QuoteCategory> categories = (state as FetchededTabState).categories.map((e) => QuoteCategory(title: e.title?.toUpperCase(), selected: e.selected)).toList();
        for (int i = 0; i < categories.length; i++) {
          QuoteCategory updated = categories[i].copyWith(selected: i == event.position);
          categories[i] = updated;
        }
        emit(FetchededTabState(categories: categories));
      }
    });
  }
}
