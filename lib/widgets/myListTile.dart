import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';
import 'package:timetable_2_flutter_admin/globals/mySpaces.dart';
import 'package:timetable_2_flutter_admin/stores/prDatabase.dart';
import 'package:timetable_2_flutter_admin/widgets/detailsDisplay.dart';
import 'package:timetable_2_flutter_admin/widgets/popUp.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';
import '../globals/myColors.dart';

// ignore: must_be_immutable
class MyListTile extends StatelessWidget {
  final Map<String, dynamic> data;
  Color sideColor;
  Color text;
  Color bgColor;

  DateTime get time => data['Time']['Timestamp'];

  MyListTile({this.data}) {
    switch (data['Type']) {
      case 'Assignment':
        sideColor = kBlack;
        break;
      case 'Viva':
      case 'Quiz':
        sideColor = kYellow;
        break;
      default:
        sideColor = kBlue;
    }
    switch (this.data['Action']) {
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
        PRDatabase myDB = context.read<PRDatabase>();
        showModalBottomSheet(
            barrierColor: Colors.transparent,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            context: context,
            builder: (context) => DetailsDisplay(data: data, db: myDB));
        // showPopup(context, _popupBody(title, type, email), '$title $status');
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${data['Code']}',
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
                                '${data['Action']}',
                                style: MyFonts.medium.setColor(text).size(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 5,
                              children: [
                                Text(
                                  ' ${data['Type']}',
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  style:
                                      MyFonts.medium.setColor(kGrey).size(15),
                                ),
                                Icon(
                                  Icons.brightness_1,
                                  size: 6,
                                  color: kBlue,
                                ),
                                Text(
                                  '${data['Platform']}',
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style:
                                      MyFonts.medium.setColor(kGrey).size(15),
                                ),
                              ])
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
                          '${data['Time']['Time']}',
                          style: MyFonts.extraBold.size(20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${data['Duration']}',
                          style: MyFonts.medium.size(15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${data['User']}',
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
              LinearGradient(stops: [0.03, 0.03], colors: [sideColor, kWhite]),
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
      top: 100,
      left: 0,
      right: 0,
      bottom: 0,
      child: PopupContent(
        content: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: new Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.note_add_outlined),
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

Widget _popupBody(String title, String type, String email) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(42.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20, 0.0),
                child: Icon(Icons.school_outlined),
              ),
              Expanded(child: Text('Course Code')),
              Expanded(
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: kBlue,
                      )),
                  child: Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, .0, 10),
                      child: Text(
                        '$title',
                        style: MyFonts.medium.size(20),
                      )),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 30.0),
          child: Container(
            height: 70,
            width: 360,
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(stops: [60, 60.25], colors: [lBlue, lBlue]),
              color: lBlue,
              border: Border.all(color: grey2, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Class'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 30.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20, 0.0),
                child: Icon(Icons.tag),
              ),
              Expanded(child: Text('tags')),
              Expanded(
                child: Text('$type'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 30.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20, 0.0),
                child: Icon(Icons.person_pin),
              ),
              Expanded(child: Text('User')),
              Expanded(
                child: Text('$email'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 30.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20, 0.0),
                child: Icon(Icons.calendar_today_outlined),
              ),
              Expanded(child: Text('Date Added')),
              Expanded(
                child: Text("11th June"),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              child: new Text("Commit Change"),
              onPressed: () {},
              color: kBlue,
              textColor: Colors.white,
            ),
            Container(height: 20.0), //SizedBox(height: 20.0),
          ],
        ),
      ],
    ),
  );
}
