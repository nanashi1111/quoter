int getCurrentYear() {
  return DateTime.now().year;
}

int getCurrentMonth() {
  return DateTime.now().month;
}

int getCurrentDayInMonth() {
  return DateTime.now().day;
}

String getMonthInString(int month) {
  String monthInString = "";
  switch (month) {
    case 1:
      monthInString = "Jan";
      break;
    case 2:
      monthInString = "Feb";
      break;
    case 3:
      monthInString = "Mar";
      break;
    case 4:
      monthInString = "Apr";
      break;
    case 5:
      monthInString = "May";
      break;
    case 6:
      monthInString = "Jun";
      break;
    case 7:
      monthInString = "Jul";
      break;
    case 8:
      monthInString = "Aug";
      break;
    case 9:
      monthInString = "Sep";
      break;
    case 10:
      monthInString = "Oct";
      break;
    case 11:
      monthInString = "Nov";
      break;
    case 12:
      monthInString = "Dec";
      break;
  }
  return monthInString;
}

String getCurrentMonthInString() {
  int month = DateTime.now().month;
  return getMonthInString(month);
}

String getDateInString(DateTime dateTime) {
  List<String> daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  String dateInString = "${daysOfWeek[dateTime.weekday % 7]}, ${getMonthInString(dateTime.month)} ${dateTime.day}/${dateTime.year}";
  return dateInString;
}
