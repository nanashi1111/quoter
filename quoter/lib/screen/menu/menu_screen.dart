import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quoter/common/dialog.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/screen/home/blocs/side_menu_bloc.dart';
import 'package:quoter/screen/home/side_menu.dart';
import 'package:quoter/screen/menu/components/mene_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext homeContext) {
    return BlocProvider<SideMenuBloc>(
      create: (_) => SideMenuBloc()..add(const SideMenuEvent.getPurchaseInfo(afterRemoveAds: false)),
      child: BlocBuilder<SideMenuBloc, SideMenuState>(
        builder: (sideMenuContext, sideMenuState) {
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/images/bg_menu.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                drawer: SideMenu(
                  onRestoreAds: () async {
                    bool restored = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.restoreProduct);
                    //bool restored = true;
                    if (restored) {
                      sideMenuContext.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo(afterRemoveAds: true));
                      showInformationDialog(homeContext, "Restored", "You have restored purchases", confirmActon: () async {});
                    } else {
                      showInformationDialog(homeContext, "Error", "Somethings went wrong, please try again later");
                    }
                  },
                  onRemoveAds: () async {
                    await sideMenuContext.pushNamed('go_premium');
                    sideMenuContext.read<SideMenuBloc>().add(const SideMenuEvent.getPurchaseInfo(afterRemoveAds: false));
                  },
                  loading: sideMenuState.loading,
                  restored: sideMenuState.restored,
                  purchased: sideMenuState.purchased,
                ),
                appBar: AppBar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  leading: Builder(builder: (context) {
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          color: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/images/ic_menu.svg',
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }),
                ),
                body: Container(
                  padding: const EdgeInsets.only(top: 20),
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Quote creator",
                        style: TextStyle(fontFamily: "Painter", fontSize: 40, color: Colors.white),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          MenuItem(
                              title: "Best quotes",
                              onClick: () {
                                homeContext.push('/category');
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          MenuItem(
                              title: "Create My Quote",
                              onClick: () {
                                Map<String, String> params = {}
                                  ..addEntries(List.of([MapEntry("quote", jsonEncode(const Quote(content: ""))), const MapEntry("backgroundPatternPos", "1")]));

                                int imagePos = 1 + Random().nextInt(86);
                                homeContext.push("/editor", extra: {'quote': '', 'backgroundImagePos': imagePos});
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          MenuItem(
                              title: "My gallery",
                              onClick: () {
                                homeContext.pushNamed("my_quotes");
                              }),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
