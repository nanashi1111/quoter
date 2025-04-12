import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/loading_view.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/models/side_menu_model.dart';
import 'package:quoter/screen/home/side_menu_header.dart';
import 'package:quoter/screen/home/side_menu_item.dart';
import 'package:quoter/screen/home/side_menu_version.dart';
import 'package:quoter/screen/remove_ads/remove_ads_modal.dart';

class SideMenu extends StatelessWidget {

  final Function onRestoreAds;
  final Function onRemoveAds;

  final bool purchased;
  final bool restored;
  final bool loading;
  final bool purchaseEnabled;

  const SideMenu({super.key,required this.onRestoreAds, required this.purchased, required this.restored, required this.loading, required this.onRemoveAds, required this.purchaseEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.65,
        color: darkCommonColor,
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: loading ? LoadingView(): ListView(
                  children: [
                    SideMenuHeader(),
                    SideMenuItem(
                        model: SideMenuModel(icon: 'assets/images/ic_my_quotes.svg', title: 'My quotes'),
                        onClick: () {
                          context.pushNamed("my_quotes");
                        }),
                    Visibility(visible: Platform.isIOS, child: SideMenuItem(
                      model: SideMenuModel(icon: 'assets/images/ic_restore.svg', title: 'Restore purchases'),
                      onClick: () async {
                        onRestoreAds();
                      },
                    ),),
                    Visibility(
                      visible: !purchased && purchaseEnabled,
                      child: SideMenuItem(
                          model: SideMenuModel(icon: 'assets/images/ic_remove_ads.svg', title: 'Remove ads'),
                          onClick: () {
                            onRemoveAds();
                          }),
                    ),
                    SideMenuItem(
                        model: SideMenuModel(icon: 'assets/images/ic_policy.svg', title: 'Privacy & Policy'),
                        onClick: () {
                          MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.openUrl, data: "https://cungdev.com/quotes-2025-privacy-policy-term-service/");
                        })
                  ],
                )),
            const SideMenuVersion()
          ],
        ));
  }

}
