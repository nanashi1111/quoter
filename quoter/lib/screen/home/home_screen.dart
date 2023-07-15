import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/screen/add/add_quote_screen.dart';
import 'package:quoter/screen/exploer/explorer_screen.dart';
import 'package:quoter/screen/home/blocs/home_bloc.dart';
import 'package:quoter/screen/search/search_quote_screen.dart';

import '../../common/colors.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  static final List<Widget> _homePages = <Widget>[
    ExplorerScreen(), AddQuoteScreen(), SearchQuoteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: appBarColor,
                leading: const Icon(Icons.search_rounded, color: tabBarColor,),
              ),

              bottomNavigationBar: SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: () {
                      context.read<HomeBloc>().add(HomeEvent(targetPosition: 0));
                    }, icon: const Icon(Icons.home, size: 35,),),
                    IconButton(onPressed: () {
                      context.read<HomeBloc>().add(HomeEvent(targetPosition: 1));
                    }, icon: const Icon(Icons.add, size: 35,),),
                    IconButton(onPressed: () {
                      context.read<HomeBloc>().add(HomeEvent(targetPosition: 2));
                    }, icon: const Icon(Icons.search_rounded, size: 35,),)
                  ],
                ),
              ),
              body: _provideContent(state),
            );
          },
        ),
    );
  }

  Widget _provideContent(HomeState state) {
    if (state is HomeStateLoading) {
      return const Center(child: Text("Loading", style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w700),),);
    } else if (state is HomeStateLoaded) {
      print("_provideContent: ${state.currentPosition}");
      return IndexedStack(
        index: state.currentPosition,
        children: _homePages,
      );
    }
    return const Center(child: Text("Loading"),);

  }

}
