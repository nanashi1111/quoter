import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/screen/diary/list/diary_list.dart';
import 'package:quoter/screen/diary/list/search/bloc/search_diary_bloc.dart';

class SearchDiaryScreen extends StatefulWidget {
  const SearchDiaryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SearchDiariesState();
  }
}

class SearchDiariesState extends State<SearchDiaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  late SearchDiaryBloc _searchDiaryBloc;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performQuery(_searchController.text);
    });
  }

  _performQuery(String query) {
    if (query.isNotEmpty) {
      _searchDiaryBloc.add(SearchDiaryEvent.search(query: query));
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchDiaryBloc>(
      create: (context) {
        _searchDiaryBloc = SearchDiaryBloc();
        return _searchDiaryBloc;
      },
      child: BlocBuilder<SearchDiaryBloc, SearchDiaryState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: darkCommonColor,
            appBar: AppBar(
              backgroundColor: darkCommonColor,
              leading: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(
                    'assets/images/ic_back.svg',
                    color: Colors.white,
                    width: 25,
                    height: 25,
                  ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              title: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search diary...",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DiaryList(
                diaries: state.diaries,
                onSelected: (diary) async {
                  await context.push("/create_diary", extra: diary);
                },
              ),
            )
          );
        },
      ),
    );
  }
}
