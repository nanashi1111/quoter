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
  final CarouselSliderController carouselController = CarouselSliderController();

  DiaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiaryHomeBloc>(
      create: (_) => DiaryHomeBloc()..add(const DiaryHomeEvent.getCardsOfYear(year: null)),
      child: BlocConsumer<DiaryHomeBloc, DiaryHomeState>(
        listener: (context, state) {
          if (state.year == DateTime.now().year) {
            int currentMonth = DateTime.now().month;
            Future.delayed(const Duration(milliseconds: 300), () {
              carouselController.jumpToPage(currentMonth - 1);
            });
          }
        },
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
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
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 38,
                        height: 38,
                        child: SvgPicture.asset('assets/images/ic_quoter_search.svg', color: Colors.white, width: 25, height: 25),
                      ),
                      onTap: () {
                        context.push("/search_diary");
                      },
                    ),
                    horizontalSpacing(10)
                  ],
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
                        children: [
                          YearSelector(
                              year: state.year,
                              onYearSelected: (selectedYear) {
                                debugPrint("SelectedYear: $selectedYear");
                                context.read<DiaryHomeBloc>().add(DiaryHomeEvent.getCardsOfYear(year: selectedYear));
                              })
                        ],
                      ),
                      verticalSpacing(40),
                      CarouselSlider(
                        options: CarouselOptions(viewportFraction: 0.8, height: height * 0.6),
                        carouselController: carouselController,
                        items: state.cards.map((card) {
                          return Builder(
                            builder: (BuildContext builderContext) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: CardDiaryItem(
                                      diaryCard: card,
                                      onDesignChanged: (card, design) {
                                        context.read<DiaryHomeBloc>().add(DiaryHomeEvent.updateCardDesign(card: card, design: design));
                                      },
                                      onClick: (card) async {
                                        debugPrint("Card Clicked: ${card.month} / ${card.year}");
                                        await context.push("/month_diaries", extra: {"month": card.month, "year": card.year});
                                        if (!context.mounted) {
                                          return;
                                        }
                                        context.read<DiaryHomeBloc>().add(const DiaryHomeEvent.refresh());
                                      }));
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  CardActions(
                      showingCalendar: state.showingCalendar,
                      onShowQuotes: () {
                        context.push("/category");
                      },
                      onWriteDiary: () async {
                        await context.push("/create_diary");
                        if (!context.mounted) {
                          return;
                        }
                        context.read<DiaryHomeBloc>().add(const DiaryHomeEvent.refresh());
                      },
                      onSwitchCardMode: () {
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
