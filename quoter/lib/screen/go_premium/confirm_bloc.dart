import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_event.dart';
part 'confirm_state.dart';
part 'confirm_bloc.freezed.dart';

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  ConfirmBloc() : super(const ConfirmState.initial(confirmed: false)) {
    on<ConfirmEvent>((event, emit) async {
      emit(state.copyWith(confirmed: !state.confirmed));
    });
  }
}
