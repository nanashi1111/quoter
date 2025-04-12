part of 'side_menu_bloc.dart';

@freezed
class SideMenuState with _$SideMenuState {
  const factory SideMenuState.initial({required bool purchased,
    required bool restored,
    required bool loading, required bool purchaseEnabled}) = _Initial;
}
