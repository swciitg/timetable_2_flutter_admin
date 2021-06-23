import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';
import 'package:timetable_2_flutter_admin/globals/mySpaces.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';
import 'package:timetable_2_flutter_admin/stores/prDatabase.dart';

import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/myFonts.dart';

class DetailsDisplay extends StatelessWidget {
  final Map<String, dynamic> data;
  final PRDatabase db;
  DetailsDisplay({this.data, this.db});
  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      child: Column(
        children: [
          AppBar(
              leading: Icon(Icons.note_add_outlined),
              title: Text(
                '${data['Code']} : ${data['Name']}',
                overflow: TextOverflow.fade,
                style: MyFonts.medium,
              )),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MySpaces.horizontalScreenPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.school_outlined),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                                'Course Code',
                                style:MyFonts.light,
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: kBlue,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${data['Code']}',
                                  style: MyFonts.medium.size(20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    TimeSlots(data: this.data),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Icon(Icons.tag)),
                          Expanded(flex: 1, child: Text('tags',style:MyFonts.light)),
                          Expanded(
                            flex: 3,
                            child: Wrap(
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text('${data['Type']}',
                                  style:MyFonts.medium,
                                ),
                                Icon(
                                  Icons.brightness_1,
                                  size: 6,
                                  color: kBlue,
                                ),
                                Text('${data['Platform']}',
                                  style:MyFonts.medium,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Icon(Icons.person_pin)),
                          Expanded(flex: 1, child: Text('User',style:MyFonts.light,
                          )),
                          Expanded(
                            flex: 3,
                            child: Text('${data['User']}',
                              style:MyFonts.medium,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Icon(Icons.calendar_today_outlined)),
                          Expanded(flex: 3, child: Text('Date Added',
                            style:MyFonts.light,
                          )),
                          Expanded(
                            flex: 5,
                            child: Text("${data['Date Added']}",style:MyFonts.medium,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 2 * MySpaces.horizontalScreenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text("Commit Change",
                        style:MyFonts.medium,
                      ),
                    ),
                    onPressed: () {
                      db.approveChange(data['ID'], data['Type']);
                      Navigator.of(context).pop();
                    },
                    style:
                        ElevatedButton.styleFrom(primary: kBlue, elevation: 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassSlots extends StatelessWidget {
  final List<dynamic> slots;
  ClassSlots({this.slots});

  @override
  Widget build(BuildContext context) {
    if (slots == null) {
      return Container();
    }
    List<Widget> classSlots = [];
    slots.forEach((element) {
      Widget myRow = Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: lBlue, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      'Class',
                      textAlign: TextAlign.center,
                      style:MyFonts.medium,
                    )),
                Container(
                  width: 2,
                  height: 65,
                  color: kGrey,
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text('${element['Time']} , ${element['Day']}',style:MyFonts.bold,),
                      ],
                    ))
              ],
            )),
      );
      classSlots.add(myRow);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: classSlots,
    );
  }
}

class TimeTiles extends StatelessWidget {
  final Map<String, dynamic> time;
  final String header;
  const TimeTiles({this.time, this.header = "On"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: lBlue, borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    '$header',
                    textAlign: TextAlign.center,
                    style:MyFonts.medium,
                  )),
              Container(
                width: 2,
                height: 65,
                color: Colors.grey[700],
              ),
              Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('${time['Time']} , ${time['Date']}',style:MyFonts.medium,),
                    ],
                  ))
            ],
          )),
    );
  }
}

class TimeSlots extends StatelessWidget {
  final Map<String, dynamic> data;
  const TimeSlots({this.data});

  @override
  Widget build(BuildContext context) {
    if (data['Type'] == "Class" || data['Type'] == "Lab") {
      return ClassSlots(slots: data['Slots']);
    }
    if (data['Type'] == "Assignment") {
      return TimeTiles(time: data['Time'], header: "Due on");
    }
    return TimeTiles(time: data['Time']);
  }
}
