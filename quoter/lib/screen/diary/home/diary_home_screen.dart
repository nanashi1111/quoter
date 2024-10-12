import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/screen/diary/home/bloc/diary_home_bloc.dart';
import 'package:quoter/screen/diary/home/components/card_actions.dart';
import 'package:quoter/screen/diary/home/components/card_diary_item.dart';
import 'package:quoter/screen/diary/home/components/year_selector.dart';

class DiaryHomeScreen extends StatelessWidget {
  const DiaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiaryHomeBloc>(
      create: (_) => DiaryHomeBloc()..add(const DiaryHomeEvent.getCardsOfYear(year: null)),
      child: BlocBuilder<DiaryHomeBloc, DiaryHomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/images/ic_quoter_search.svg', color: Colors.white, width: 25, height: 25),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              actions: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(right: 15),
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset('assets/images/ic_diary_setting.svg', color: Colors.white, width: 50, height: 50),
                  ),
                  onTap: () {},
                )
              ],
              title: Text(
                '',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
              ),
              centerTitle: Platform.isIOS,
              backgroundColor: darkCommonColor,
            ),
            backgroundColor: darkCommonColor,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //verticalSpacing(10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [YearSelector(year: state.year, onYearSelected: (selectedYear) {
                          debugPrint("SelectedYear: $selectedYear");
                          context.read<DiaryHomeBloc>().add(DiaryHomeEvent.getCardsOfYear(year: selectedYear));
                        })],
                      ),
                      verticalSpacing(40),
                      CarouselSlider(
                        options: CarouselOptions(height: 500.0, viewportFraction: 0.8),
                        items: state.cards.map((card) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: CardDiaryItem(diaryCard: card, onClick: (card) {}));
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  CardActions(showingCalendar: state.showingCalendar, onShowQuotes: () {}, onWriteDiary: () {
                    context.push("/create_diary");
                  }, onSwitchCardMode: () {
                    context.read<DiaryHomeBloc>().add(const DiaryHomeEvent.switchViewMode());
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
