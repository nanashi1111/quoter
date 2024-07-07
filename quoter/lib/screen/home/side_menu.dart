import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/models/side_menu_model.dart';
import 'package:quoter/screen/home/side_menu_header.dart';
import 'package:quoter/screen/home/side_menu_item.dart';
import 'package:quoter/screen/home/side_menu_version.dart';
import 'package:quoter/screen/remove_ads/remove_ads_modal.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.65,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              children: [
                SideMenuHeader(),
                SideMenuItem(
                    model: SideMenuModel(icon: 'assets/images/ic_my_quotes.svg', title: 'My quotes'),
                    onClick: () {
                      context.pushNamed("my_quotes");
                    }),
                SideMenuItem(
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
                                onRemoveAds1Month: () {},
                                onRemoveAds2Months: () {},
                                onRemoveAds6Months: () {},
                                onRemoveAdsForever: () {},
                              ),
                            );
                          });
                    }),
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
