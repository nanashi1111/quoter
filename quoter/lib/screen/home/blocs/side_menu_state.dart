part of 'side_menu_bloc.dart';

@freezed
class SideMenuState with _$SideMenuState {
  const factory SideMenuState.initial({required bool purchased, required bool loading}) = _Initial;
}
