import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/card_diary_ext.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/date_time_ext.dart';
import 'package:quoter/common/images.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary_card.dart';
import 'package:quoter/screen/diary/home/components/card_design_panel.dart';

class CardDiaryItem extends StatelessWidget {
  final DiaryCard diaryCard;
  final Function(DiaryCard) onClick;
  final Function(DiaryCard, String) onDesignChanged;

  const CardDiaryItem({super.key, required this.diaryCard, required this.onClick, required this.onDesignChanged});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.6;
    double width = height * 0.8;
    return GestureDetector(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            diaryCard.useSolidBackgroundColor() ? _provideSolidBackgroundColor(context): _provideImage(context),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: width,
                height: height,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            _provideMonth(),
            _provideStatistic(),
            _provideOptions(context)
          ],
        ),
      ),
      onTap: () {
        onClick(diaryCard);
      },
    );
  }

  Widget _provideOptions(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: GestureDetector(
        child: SvgPicture.asset(
          "assets/images/ic_three_dots.svg",
          width: 20,
          height: 20,
          color: Colors.white,
        ),
        onTap: () {
          debugPrint("Click on options");
          _showCardDesignBottomSheet(context);
        },
      ),
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

  Widget _provideSolidBackgroundColor(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.6;
    double width = height * 0.8;
    return Container(
      width: width, height: height, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: HexColor(diaryCard.image)),
    );
  }

  Widget _provideImage(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.6;
    double width = height * 0.8;
    Image image = diaryCard.image.isNotEmpty
        ? Image.memory(
            base64Decode(diaryCard.image),
            fit: BoxFit.cover,
            width: width,
            height: height,
          )
        : Image(
            image: ResizeImage(AssetImage(diaryCard.getDefaultImagePath(), ),width: width.toInt(), height: height.toInt()),
            fit: BoxFit.cover,
      width: width,
      height: height,
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: image,
    );
  }

  _showCardDesignBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (context) {
          return  CardDesignPanel(onColorSelected: (hex) {
            onDesignChanged(diaryCard, hex);
            context.pop();
          }, onImageSelected: (file) async {
            String base64Image = await ImageUtils.encodeImage(File(file.path));
            onDesignChanged(diaryCard, base64Image);
            if (context.mounted) {
              context.pop();
            }
          },);
        });
  }
}
