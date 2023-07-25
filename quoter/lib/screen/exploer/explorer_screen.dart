import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/models/quote_category.dart';
import 'package:quoter/screen/exploer/blocs/fetch_tab_bloc.dart';
import 'package:quoter/screen/exploer/quotes_list.dart';
import 'package:quoter/screen/loading/loading_screen.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FetchTabBloc()..add(FetchTabEvent()),
        child: BlocConsumer<FetchTabBloc, TabState>(
          builder: (context, state) {
            _fetchTabBloc ??= context.read<FetchTabBloc>();
            return _provideWidget(state);
          },
          listener: (context, state) {},
        ));
  }

  Widget _provideWidget(TabState state) {
    if (state is FetchingTabs) {
      return LoadingScreen();
    }

    if (state is FetchededTabState) {
      _controller ??= TabController(length: state.categories.length, vsync: this)
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
                tabs: _provideTabBar(state),
                controller: _controller,
              ),
              Expanded(child: TabBarView(controller: _controller, children: _provideTabContent(state)))
            ],
          ));
    }
    return Container();
  }

  List<Widget> _provideTabBar(FetchededTabState state) {
    _tabBars = List<Widget>.of([], growable: true);
    for (int i = 0; i < state.categories.length; i++) {
      QuoteCategory category = state.categories[i];
      _tabBars!.add(Tab(
        icon: Text(
          "${category.title}",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: (category.selected ?? false) ? selectedTabTextColor : unselectedTabTextColor),
        ),
      ));
    }
    return _tabBars!;
  }

  List<QuotesList> _provideTabContent(FetchededTabState state) {
    if (_tabContents == null) {
      _tabContents = List<QuotesList>.of([], growable: true);
      for (int i = 0; i < state.categories.length; i++) {
        _tabContents!.add(QuotesList(
          category: state.categories[i],
        ));
      }
    }
    return _tabContents!;
  }
}
