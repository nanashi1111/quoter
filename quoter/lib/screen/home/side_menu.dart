import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quoter/common/loading_view.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/models/side_menu_model.dart';
import 'package:quoter/screen/home/side_menu_header.dart';
import 'package:quoter/screen/home/side_menu_item.dart';
import 'package:quoter/screen/home/side_menu_version.dart';
import 'package:quoter/screen/remove_ads/remove_ads_modal.dart';

class SideMenu extends StatelessWidget {

  final Function onRemoveAds1Month;
  final Function onRemoveAds2Month;
  final Function onRemoveAds6Month;
  final Function onRemoveAdsForever;
  final Function onRestoreAds;

  final bool purchased;
  final bool restored;
  final bool loading;

  const SideMenu({super.key, required this.onRemoveAds1Month, required this.onRemoveAds2Month, required this.onRemoveAds6Month, required this.onRemoveAdsForever, required this.onRestoreAds, required this.purchased, required this.restored, required this.loading});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.65,
        color: Colors.white,
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
                    Visibility(visible: purchased && !restored,child: SideMenuItem(
                      model: SideMenuModel(icon: 'assets/images/ic_remove_ads.svg', title: 'Restore purchases'),
                      onClick: () async {
                        onRestoreAds();
                      },
                    ),),
                    Visibility(
                      visible: !purchased && !restored,
                      child: SideMenuItem(
                          model: SideMenuModel(icon: 'assets/images/ic_remove_ads.svg', title: 'Remove ads'),
                          onClick: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                builder: (modalContext) {
                                  return SingleChildScrollView(
                                    child: RemoveAdsModal(
                                      onRemoveAds1Month: ()  {
                                        onRemoveAds1Month();
                                      },
                                      onRemoveAds2Months: ()  {
                                        onRemoveAds2Month();
                                      },
                                      onRemoveAds6Months: ()  {
                                        onRemoveAds6Month();
                                      },
                                      onRemoveAdsForever: ()  {
                                        onRemoveAdsForever();
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
                )),
            const SideMenuVersion()
          ],
        ));
  }

}
