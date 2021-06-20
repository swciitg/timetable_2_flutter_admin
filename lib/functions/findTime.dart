import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timetable_2_flutter_admin/globals/days.dart';

Map<String, String> classTime(List<dynamic> slots) {
  if (slots == null) {
    return {"Day": "-", "Time": "-"};
  }
  int today = DateTime.now().weekday;
  int minimum = 0;
  for (int i = 0; i < slots.length; i++) {
    int day = kWeekday[slots[i]['Day']];
    int minDay = kWeekday[slots[minimum]['Day']];
    if ((day - today) % 7 < (minDay - today) % 7) {
      minimum = i;
    }
  }

  return {"Day": slots[minimum]['Day'], "Time": slots[minimum]['Time']};
}

Map<String, String> findTime(Timestamp ts) {
  if (ts == null) {
    return {"Day": "-", "Time": "-"};
  }
  DateTime day = ts.toDate();
  return {
    "Day": DateFormat.EEEE().format(day),
    "Time": DateFormat.jm().format(day),
    "Date": DateFormat('d MMMM').format(day),
  };
}
