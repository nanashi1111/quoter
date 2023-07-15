
import 'package:equatable/equatable.dart';

class QuoteCategory extends Equatable {

  String title;
  bool selected;

  QuoteCategory({required this.title, required this.selected});


  @override
  List<Object?> get props => [title, selected];
}