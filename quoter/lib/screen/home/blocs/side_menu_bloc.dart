import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/repositories/ads_repository.dart';

part 'side_menu_event.dart';
part 'side_menu_state.dart';
part 'side_menu_bloc.freezed.dart';

class SideMenuBloc extends Bloc<SideMenuEvent, SideMenuState> {
  SideMenuBloc() : super(const SideMenuState.initial(purchased: false, restored:false, loading: true)) {
    on<_GetPurchaseInfo>((event, emit) async {
      emit(state.copyWith(loading: true));
      if (event.afterRemoveAds) {
        await AdsRepository.instance.setPurchaseRestored(true);
        await AdsRepository.instance.setAdsEnabled(false);
      }
      String purchasedProduct = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.getPurchasedProduct);
      bool restored = await AdsRepository.instance.isPurchaseRestored();
      debugPrint("purchasedProduct: $purchasedProduct");
      emit(state.copyWith(purchased: purchasedProduct.isNotEmpty, restored: restored, loading: false));
    });
  }
}