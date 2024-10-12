import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/card_diary_ext.dart';
import 'package:quoter/common/date_time_ext.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary_card.dart';

class CardDiaryItem extends StatelessWidget {
  final DiaryCard diaryCard;
  final Function(DiaryCard) onClick;

  const CardDiaryItem({super.key, required this.diaryCard, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _provideImage(),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            _provideMonth(),
            _provideStatistic(),
            _provdeOptions()
          ],
        ),
      ),
      onTap: () {
        onClick(diaryCard);
      },
    );
  }

  Widget _provdeOptions() {
    return Positioned(
      right: 20,
      bottom: 20,
      child: GestureDetector(child: SvgPicture.asset(
        "assets/images/ic_three_dots.svg",
        width: 20,
        height: 20,
        color: Colors.white,
      ), onTap: () {
        debugPrint("Click on options");
      }, ),
    );
  }

  Widget _provideStatistic() {
    double value = diaryCard.diary_count / getNumberOfDayInMonth(diaryCard.month, diaryCard.year);
    debugPrint("value: $value");
    return Positioned(
        left: 20,
        bottom: 20,
        right: 40,
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${diaryCard.diary_count}/${getNumberOfDayInMonth(diaryCard.month, diaryCard.year)}",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
              ),
              verticalSpacing(5),
              LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              )
            ],
          ),
        ));
  }

  Widget _provideMonth() {
    return Positioned(
      top: 20,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            diaryCard.month.toString(),
            style: GoogleFonts.lato(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          verticalSpacing(10),
          Text(
            diaryCard.monthInString(),
            style: GoogleFonts.lato(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _provideImage() {
    Image image = diaryCard.image.isNotEmpty
        ? Image.network(
            diaryCard.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        : Image.asset(
            diaryCard.getDefaultImagePath(),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: image,
    );
  }
}
