import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timetable_2_flutter_admin/globals/mySpaces.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';
import 'package:timetable_2_flutter_admin/widgets/appBar.dart';
import 'package:timetable_2_flutter_admin/widgets/myListTile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView.separated(
          itemCount: testData.length + 2,
          separatorBuilder: (context, _) => SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            if (index == 0 || index == (testData.length + 1)) {
              return Container();
            }
            Map<String, String> item = testData[index - 1];
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: MyListTile(
                title: item['title'],
                type: item['type'],
                duration: item['duration'],
                tag: item['tag'],
                time: item['time'],
              ),
              actions: [
                IconSlideAction(
                  caption: 'Approve',
                  icon: Icons.check,
                  color: Colors.green,
                  onTap: () {
                    print('You approved ${item['title']}');
                    setState(() {
                      testData.removeAt(index - 1);
                    });
                  },
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  caption: 'Delete',
                  icon: Icons.close,
                  color: Colors.red,
                  onTap: () {
                    print('You did not approve ${item['title']}');
                    setState(() {
                      testData.removeAt(index - 1);
                    });
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

List<Map<String, String>> testData = [
  {
    "title": "CS 101",
    "type": "Theory",
    "time": "8 am",
    "duration": "1 hour",
    "tag": "MS Teams"
  },
  {
    "title": "CS 223",
    "type": "Theory",
    "time": "9 am",
    "duration": "1 hour",
    "tag": "MS Teams"
  },
  {
    "title": "CS 224",
    "type": "Theory",
    "time": "10 am",
    "duration": "1 hour",
    "tag": "MS Teams"
  },
  {
    "title": "CS 110",
    "type": "Assignment",
    "time": "12 am",
    "duration": "due date",
    "tag": "Moodle"
  },
  {
    "title": "CS 245",
    "type": "Quiz",
    "time": "11 am",
    "duration": "1.5 hour",
    "tag": "MS Forms"
  },
  {
    "title": "HSS 123",
    "type": "Quiz",
    "time": "2 pm",
    "duration": "3 hour",
    "tag": "MS Forms"
  },
];
