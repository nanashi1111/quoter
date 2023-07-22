import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/screen/exploer/explorer_screen.dart';
import 'package:quoter/screen/home/blocs/home_bloc.dart';
import 'package:quoter/screen/loading/loading_screen.dart';
import 'package:quoter/screen/search/search_quote_screen.dart';

import '../../common/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  static final List<Widget> _homePages = <Widget>[const ExplorerScreen(), SearchQuoteScreen()];

  late HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)  {
        _bloc = HomeBloc();
        return _bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0,
              leading: const Icon(
                Icons.search_rounded,
                color: tabBarColor,
              ),
            ),
            extendBody: true,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(5),
              child:SizedBox(
                width: 80, height: 80,
                child:  FloatingActionButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Map<String, String> params = {}..addEntries(
                      List.of([MapEntry("quote", jsonEncode(const Quote(content: ""))), const MapEntry("backgroundPatternPos", "1")])
                    );
                    context.pushNamed("editor", pathParameters: params);
                  },
                  child: SvgPicture.asset(
                    'assets/images/ic_quoter_plus.svg',
                    colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                    width: 50,
                    height: 50,
                  ),
                ),
              )
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: _provideAppBar(context,state),
            body: _provideContent(state),
          );
        },
      ),
    );
  }

  Color _provideTabBarItemColor(int position, int selectedPosition) {
    if (position == selectedPosition) {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }

  Widget _provideAppBar(BuildContext context, HomeState state) {
    if (state is HomeStateLoaded) {
      int currentPosition = state.currentPosition;
      return BottomAppBar(
        color: Colors.white,
        elevation: 10,
        height: 70,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        //shape of notch
        notchMargin: 5,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () { context.read<HomeBloc>().add(HomeEvent(targetPosition: 0)); },
              child: SvgPicture.asset(
                'assets/images/ic_quoter_home.svg',
                colorFilter: ColorFilter.mode(_provideTabBarItemColor(0, currentPosition), BlendMode.srcIn),
                width: 35,
                height: 35,
              ),
            ),
            GestureDetector(
              onTap: () { context.read<HomeBloc>().add(HomeEvent(targetPosition: 1)); },
              child: SvgPicture.asset(
                'assets/images/ic_quoter_search.svg',
                colorFilter: ColorFilter.mode(_provideTabBarItemColor(1, currentPosition), BlendMode.srcIn),
                width: 35,
                height: 35,
              ),
            )
          ],
        ),
      );
    }
    return const Text("");

  }

  Widget _provideContent(HomeState state) {
    if (state is HomeStateLoading) {
      return const Center(
        child: Text(
          "Loading",
          style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w700),
        ),
      );
    } else if (state is HomeStateLoaded) {
      return IndexedStack(
        index: state.currentPosition,
        children: _homePages,
      );
    }
    return LoadingScreen();
  }
}
