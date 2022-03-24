// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';

// extension DateTimeExtension on DateTime {
//   DateTime removeUTCFormat() {
//     return DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(toString())));
//   }

//   DateTime toCalendarFormat() {
//     return DateTime.utc(year, month, day, 0, 0, 0);
//   }

//   bool inRange(DateTime day1, DateTime day2) {
//     return (isSameDay(this, day1) || isSameDay(this, day2) || (isAfter(day1) && isBefore(day2)));
//   }

//   int weekNumber() {
//     int numOfWeeks(int year) {
//       var dec28 = DateTime(year, 12, 28);
//       var dayOfDec28 = int.parse(DateFormat('D').format(dec28));
//       return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
//     }

//     var dayOfYear = int.parse(DateFormat('D').format(this));
//     var woy = ((dayOfYear - weekday + 10) / 7).floor();
//     if (woy < 1) {
//       woy = numOfWeeks(year - 1);
//     } else if (woy > numOfWeeks(year)) {
//       woy = 1;
//     }
//     return woy;
//   }
// }

// extension DateTimeRangeExtension on DateTimeRange {
//   double percentOfRange(DateTimeRange range) {
//     return (duration.inSeconds / range.duration.inSeconds) * 100.0;
//   }
// }
