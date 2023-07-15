part of 'fetch_tab_bloc.dart';

abstract class TabEvent extends Equatable {
}

class FetchTabEvent extends TabEvent {
  @override
  List<Object?> get props => [];

}

class SelectTabEvent extends TabEvent {

  final int position;

  SelectTabEvent({required this.position});

  @override
  List<Object?> get props => [position];

}