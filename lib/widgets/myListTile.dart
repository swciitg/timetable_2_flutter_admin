import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';
import 'package:timetable_2_flutter_admin/globals/mySpaces.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';
import 'package:timetable_2_flutter_admin/widgets/appBar.dart';
import 'package:timetable_2_flutter_admin/widgets/popUp.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String time;
  final String duration;
  final String type;
  final String email;
  final String status;
  Color sideColor;
  Color text;
  Color bgColor;

  MyListTile(
      {this.title,
      this.status,
      this.type,
      this.time,
      this.duration,
      this.email}) {
    switch (this.type) {
      case 'Assignment':
        sideColor = kBlack;
        break;
      case 'Quiz':
        sideColor = kYellow;
        break;
      default:
        sideColor = kBlue;
    }
    switch (this.status) {
      case 'cancel':
        text = kRed;
        bgColor = lRed;
        break;
      case 'update':
        text = kYellow;
        bgColor = lYellow;
        break;
      default:
        bgColor = lBlue;
        text = kBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      // When the user taps the button, show a dialog box.
      onTap: () {
        showModalBottomSheet(
            barrierColor: Colors.transparent,
            isScrollControlled: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppBar(
                      leading: Icon(Icons.note_add_outlined),
                      title: Text('$title'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MySpaces.horizontalScreenPadding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.school_outlined),
                              Expanded(child: Text('Course Code')),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: kBlue,
                                      )),
                                  child: Text('$title'),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.tag),
                              Expanded(child: Text('tags')),
                              Expanded(
                                child: Text('$type'),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person_pin),
                              Expanded(child: Text('User')),
                              Expanded(
                                child: Text('$email'),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              Expanded(child: Text('Date Added')),
                              Expanded(
                                child: Text("11th June"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
        // showPopup(context, _popupBody(), '$title $status');
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(MySpaces.listTileLeftPadding, 0, 0,
              MySpaces.horizontalScreenPadding),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$title',
                            style: MyFonts.extraBold.size(25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            // color: kBlack,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(18.25)),
                            // height: 20,
                            // width: 79,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                '$status',
                                style: MyFonts.medium.setColor(text).size(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$type',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: MyFonts.medium.setColor(kGrey).size(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '$time',
                          style: MyFonts.extraBold.size(20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '$duration',
                          style: MyFonts.medium.size(15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '$email',
                          style: MyFonts.medium.setColor(kGrey).size(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        height: 100,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(stops: [0.05, 0.05], colors: [sideColor, kWhite]),
          color: kWhite,
          border: Border.all(color: grey2, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

showPopup(BuildContext context, Widget widget, String title,
    {BuildContext popupContext}) {
  Navigator.push(
    context,
    PopupLayout(
      top: 1,
      left: 10,
      right: 10,
      bottom: 10,
      child: PopupContent(
        content: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: new Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  try {
                    Navigator.pop(context); //close the popup
                  } catch (e) {}
                },
              );
            }),
            brightness: Brightness.light,
          ),
          body: widget,
        ),
      ),
    ),
  );
}

Widget _popupBody() {
  return Container();
}
