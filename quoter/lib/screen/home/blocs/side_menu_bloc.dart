import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/method_channel_handler.dart';

part 'side_menu_event.dart';
part 'side_menu_state.dart';
part 'side_menu_bloc.freezed.dart';

class SideMenuBloc extends Bloc<SideMenuEvent, SideMenuState> {
  SideMenuBloc() : super(const SideMenuState.initial(purchased: false, loading: true)) {
    on<_GetPurchaseInfo>((event, emit) async {
      String purchasedProduct = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.getPurchasedProduct);
      debugPrint("purchasedProduct: $purchasedProduct");
      emit(state.copyWith(purchased: purchasedProduct.isNotEmpty, loading: false));
    });
  }
}
