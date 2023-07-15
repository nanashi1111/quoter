part of 'home_bloc.dart';

 class HomeEvent extends Equatable {
  int targetPosition;
   HomeEvent({required this.targetPosition});

  @override
  // TODO: implement props
  List<Object?> get props => [targetPosition];
}
