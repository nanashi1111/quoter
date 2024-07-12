part of 'side_menu_bloc.dart';

@freezed
class SideMenuEvent with _$SideMenuEvent {
  const factory SideMenuEvent.getPurchaseInfo({required bool afterRemoveAds}) = _GetPurchaseInfo;
}
