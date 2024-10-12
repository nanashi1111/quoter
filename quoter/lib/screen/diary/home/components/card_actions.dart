import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/date_time_ext.dart';
import 'package:quoter/common/views.dart';

class CardActions extends StatelessWidget {
  final bool showingCalendar;
  final Function onShowQuotes;
  final Function onWriteDiary;
  final Function onSwitchCardMode;

  const CardActions({super.key, required this.showingCalendar, required this.onShowQuotes, required this.onWriteDiary, required this.onSwitchCardMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const WeatherIcon(),
        Wrap(
          children: [
            CardActionItem(imagePath: "assets/images/ic_quotes.svg", backgroundColor: Colors.white, iconColor: Colors.black, onClick: onShowQuotes),
            horizontalSpacing(15),
            CardActionItem(imagePath: "assets/images/ic_write_diary.svg", backgroundColor: Colors.white, iconColor: Colors.black, onClick: onWriteDiary),
            horizontalSpacing(15),
            showingCalendar ? CardActionItem(imagePath: "assets/images/ic_return_card_mode.svg", backgroundColor: HexColor("77CDFF"), iconColor: Colors.white, onClick:
            onSwitchCardMode) :
            CardActionItem(imagePath: "assets/images/ic_calendar.svg", backgroundColor: Colors.white, iconColor: Colors.black, onClick: () { onSwitchCardMode(); }),
            horizontalSpacing(10),
          ],
        )
      ],
    );
  }
}

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key});

  @override
  Widget build(BuildContext context) {
    String description = "${getCurrentMonthInString()}, ${getCurrentDayInMonth()}/${getCurrentYear()}";
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.8))),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/ic_weather.svg",
              width: 30,
              color: Colors.white.withOpacity(0.8),
            ),
            horizontalSpacing(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today",
                  style: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontSize: 12),
                ),
                verticalSpacing(5),
                Text(
                  description,
                  style: GoogleFonts.lato(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardActionItem extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final Color iconColor;
  final Function onClick;

  const CardActionItem({super.key, required this.imagePath, required this.backgroundColor, required this.onClick, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(30)),
        child: SvgPicture.asset(
          imagePath,
          color: iconColor,
          width: 20,
          height: 20,
        ),
      ),
      onTap: () {
        onClick();
      },
    );
  }
}
