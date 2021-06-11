import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';

AppBar appBar() {
  return AppBar(
    actions: [
      Padding(
        padding: EdgeInsets.all(8),
        child: IconButton(
          icon: const Icon(Icons.calendar_today),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    ],
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
    elevation: 0.0,
    bottom: TabBar(
      tabs: [
        Tab(
            icon: Text(
          'Push Requests',
          style: MyFonts.medium,
        )),
        Tab(
            icon: Text(
          'My Department',
          style: MyFonts.medium,
        )),
      ],
    ),
  );
}
