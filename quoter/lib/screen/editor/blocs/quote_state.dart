part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {}

class QuoteStateInit extends QuoteState {
  @override
  List<Object?> get props => [];
}

class QuoteStateSaved extends QuoteState {
  int savedTime;
  QuoteStateSaved({required this.savedTime});
  @override
  List<Object?> get props => [savedTime];
}
