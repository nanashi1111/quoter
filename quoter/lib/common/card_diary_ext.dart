
import 'package:quoter/models/diary_card.dart';

extension CardDiaryExt on DiaryCard {

  String monthInString() {
    String month = "";
    switch(this.month) {
      case 1:
        month = "jan";
        break;
      case 2:
        month = "feb";
        break;
      case 3:
        month = "mar";
        break;
      case 4:
        month = "apr";
        break;
      case 5:
        month = "may";
        break;
      case 6:
        month = "jun";
        break;
      case 7:
        month = "jul";
        break;
      case 8:
        month = "aug";
        break;
      case 9:
        month = "sep";
        break;
      case 10:
        month = "oct";
        break;
      case 11:
        month = "nov";
        break;
      case 12:
        month = "dec";
        break;
    }
    return month.toUpperCase();
  }

  String getDefaultImagePath() {
    String month = "";
    switch(this.month) {
      case 1:
        month = "jan";
        break;
      case 2:
        month = "feb";
        break;
      case 3:
        month = "mar";
        break;
      case 4:
        month = "apr";
        break;
      case 5:
        month = "may";
        break;
      case 6:
        month = "jun";
        break;
      case 7:
        month = "jul";
        break;
      case 8:
        month = "aug";
        break;
      case 9:
        month = "sep";
        break;
      case 10:
        month = "oct";
        break;
      case 11:
        month = "nov";
        break;
      case 12:
        month = "dec";
        break;
    }
    return "assets/images/bg_$month.jpg";
  }

}