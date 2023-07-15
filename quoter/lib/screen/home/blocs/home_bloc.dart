import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeStateLoaded(currentPosition: 0)) {
    on<HomeEvent>(mapEventToState);
  }

  Future mapEventToState(HomeEvent event, Emitter<HomeState> emitter) async {
    print("event: ${event.targetPosition}");
    if (state is HomeStateLoaded && (state as HomeStateLoaded).currentPosition == event.targetPosition) {
      return;
    }
    emit(HomeStateLoaded(currentPosition: event.targetPosition));

  }

}
