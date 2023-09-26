part of 'quote_bloc.dart';

@immutable
abstract class QuoteEvent {}

class SaveQuoteEvent extends QuoteEvent {
  final QuoteEditor quoteEditor;
  SaveQuoteEvent({required this.quoteEditor});
}
