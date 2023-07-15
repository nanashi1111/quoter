part of 'home_bloc.dart';

abstract class HomeState extends Equatable {

}

class HomeStateLoading extends HomeState {
  @override
  List<Object?> get props => [];

}

class HomeStateLoaded extends HomeState {
  int currentPosition;

  HomeStateLoaded({required this.currentPosition});

  @override
  List<Object?> get props => [currentPosition];

}


