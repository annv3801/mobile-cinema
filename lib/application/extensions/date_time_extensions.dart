import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtensions on DateTime {
  bool isSameDay(DateTime date) {
    return date.year == year && date.month == month && date.day == day;
  }

  String get toWeekdayString {
    final now = DateTime.now();

    if (isSameDay(now)) return tr("today");

    switch (weekday) {
      case DateTime.monday:
        return tr("monday");
      case DateTime.tuesday:
        return tr("tuesday");
      case DateTime.wednesday:
        return tr("wednesday");
      case DateTime.thursday:
        return tr("thursday");
      case DateTime.friday:
        return tr("friday");
      case DateTime.saturday:
        return tr("saturday");
      case DateTime.sunday:
        return tr("sunday");
      default:
        return "";
    }
  }

  String get toDateString => DateFormat('HH:mm').format(this);

}
