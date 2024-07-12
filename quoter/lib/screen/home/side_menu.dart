import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quoter/common/loading_view.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/common/toast.dart';
import 'package:quoter/models/side_menu_model.dart';
import 'package:quoter/screen/home/blocs/side_menu_bloc.dart';
import 'package:quoter/screen/home/side_menu_header.dart';
import 'package:quoter/screen/home/side_menu_item.dart';
import 'package:quoter/screen/home/side_menu_version.dart';
import 'package:quoter/screen/remove_ads/remove_ads_modal.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SideMenuBloc>(
      create: (context) => SideMenuBloc()..add(const SideMenuEvent.getPurchaseInfo()),
      child: BlocBuilder<SideMenuBloc, SideMenuState>(
        builder: (context, state) {
          return Container(
              width: MediaQuery.sizeOf(context).width * 0.65,
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: _provideSideMenu(context, state)),
                  const SideMenuVersion()
                ],
              ));
        },
      ),
    );
  }

  Widget _provideSideMenu(BuildContext context, SideMenuState state) {
    if (state.loading) {
      return LoadingView();
    } else {
      return ListView(
        children: [
          SideMenuHeader(),
          SideMenuItem(
              model: SideMenuModel(icon: 'assets/images/ic_my_quotes.svg', title: 'My quotes'),
              onClick: () {
                context.pushNamed("my_quotes");
              }),
          Visibility(visible: state.purchased,child: SideMenuItem(
            model: SideMenuModel(icon: 'assets/images/ic_remove_ads.svg', title: 'Restore purchases'),
            onClick: () async {
              bool restoredSuccess = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.restoreProduct);
              debugPrint("RestoredResult: $restoredSuccess");
              if (restoredSuccess) {
                showToast(context, "You have restored purchases");
              } else {
                showToast(context, "Something failed, please try again later");
              }
              context.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo());
            },
          ),),
          Visibility(
            visible: !state.purchased,
            child: SideMenuItem(
                model: SideMenuModel(icon: 'assets/images/ic_remove_ads.svg', title: 'Remove ads'),
                onClick: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      builder: (context) {
                        return SingleChildScrollView(
                          child: RemoveAdsModal(
                            onRemoveAds1Month: () async {
                              bool purchased = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAds1Month);
                              if (purchased) {
                                showToast(context, "You have paid for 1 month ads free");
                                context.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo());
                              } else {
                                showToast(context, "Something failed, please try again later");
                              }
                            },
                            onRemoveAds2Months: () async {
                              bool purchased = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAds2Months);
                              if (purchased) {
                                showToast(context, "You have paid for 2 months ads free");
                                context.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo());
                              } else {
                                showToast(context, "Something failed, please try again later");
                              }
                            },
                            onRemoveAds6Months: () async {
                              bool purchased = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAds6Months);
                              if (purchased) {
                                showToast(context, "You have paid for 6 months ads free");
                                context.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo());
                              } else {
                                showToast(context, "Something failed, please try again later");
                              }
                            },
                            onRemoveAdsForever: () async {
                              bool purchased = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAdsForever);
                              if (purchased) {
                                showToast(context, "You have paid for ads free");
                                context.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo());
                              } else {
                                showToast(context, "Something failed, please try again later");
                              }
                            },
                          ),
                        );
                      });
                }),
          ),
          SideMenuItem(
              model: SideMenuModel(icon: 'assets/images/ic_policy.svg', title: 'Privacy & Policy'),
              onClick: () {
                MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.showPrivacy, data: "https://cungdev.com/quote-creator-privacy-policy/");
              })
        ],
      );
    }

  }
}
