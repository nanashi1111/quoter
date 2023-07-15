part of 'fetch_tab_bloc.dart';

abstract class TabState extends Equatable {
}

class FetchingTabs extends TabState {
  @override
  List<Object?> get props => [];
}

class FetchededTabState extends TabState {

  List<QuoteCategory> categories;

  FetchededTabState({required this.categories});

  @override
  List<Object?> get props => [categories];
}

