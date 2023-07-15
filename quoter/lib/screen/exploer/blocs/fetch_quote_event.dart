part of 'fetch_quote_bloc.dart';


class FetchQuoteEvent extends Equatable {

  String category;
  FetchQuoteEvent({required this.category});


  @override
  List<Object?> get props => [category];

}

