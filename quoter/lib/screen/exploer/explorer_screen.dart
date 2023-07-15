import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/models/category.dart';
import 'package:quoter/screen/exploer/blocs/fetch_tab_bloc.dart';
import 'package:quoter/screen/exploer/quotes_list.dart';

class ExplorerScreen extends StatefulWidget {


  const ExplorerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExplorerScreenState();
  }
}

class _ExplorerScreenState extends State<ExplorerScreen> with SingleTickerProviderStateMixin {
  TabController? _controller;
  List<QuotesList>? _tabContents;
  List<Widget>? _tabBars;
  FetchTabBloc? _fetchTabBloc;
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _fetchTabBloc?.add(FetchTabEvent());
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FetchTabBloc(),
        child: BlocBuilder<FetchTabBloc, TabState>(
          builder: (context, state) {
            _fetchTabBloc ??= context.read<FetchTabBloc>();
            return _provideWidget(state);
          },
        ));
  }

  Widget _provideWidget(TabState state) {
    if (state is FetchingTabs) {
      return const Center(
        child: Text("Loading..."),
      );
    }
    _controller ??= TabController(
          length: (state as FetchededTabState).categories.length, vsync: this)
        ..addListener(() {
          _fetchTabBloc?.add(SelectTabEvent(position: _controller!.index));
        });
    return Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: Colors.blue,
              tabs: _provideTabBar(
                  state as FetchededTabState
              ),
              controller: _controller,
            ),
            Expanded(child: TabBarView(controller: _controller, children: _provideTabContent(state as FetchededTabState)))
          ],
        ));
  }

  List<Widget> _provideTabBar(FetchededTabState state) {
    _tabBars = List<Widget>.of([], growable: true);
    print("_provideTabBar: ${state.categories}");
    for (int i = 0; i < state.categories.length; i++) {
      QuoteCategory category = state.categories[i];
      _tabBars!.add(Tab(
        icon: Text(
          "${category.title}",
          style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w900, color: category.selected ? selectedTabTextColor : unselectedTabTextColor),
        ),
      ));
    }
    return _tabBars!;
  }

  List<QuotesList> _provideTabContent(FetchededTabState state) {
    if (_tabContents == null) {
      _tabContents = List<QuotesList>.of([], growable: true);
      for (int i = 0; i < state.categories.length; i++) {
        _tabContents!.add(QuotesList(category: state.categories[i],));
      }
    }
    return _tabContents!;
  }
}
