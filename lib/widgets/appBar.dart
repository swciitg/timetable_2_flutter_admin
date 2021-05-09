import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';

AppBar appBar() {
  return AppBar(
    title: RichText(
      text: TextSpan(
          text: 'timetable',
          style: MyFonts.extraBold.factor(4.39).letterSpace(1.0),
          children: [
            TextSpan(
              text: '.',
              style: MyFonts.extraBold.factor(5.85).setColor(kYellow),
            )
          ]),
    ),
  );
}
