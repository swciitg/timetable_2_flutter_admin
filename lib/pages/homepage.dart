import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/pages/myDepartment.dart';
import 'package:timetable_2_flutter_admin/pages/pushRequest.dart';
import 'package:timetable_2_flutter_admin/widgets/appBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: appBar(),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: kBlue,
                    ),
                    child: Text('Drawer Header'),
                  ),
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Item 2'),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // bottomNavigationBar: new Material(
            //   color: Colors.pink,
            // ),
            body: TabBarView(children: <Widget>[
              PushRequest(),
              MyDepartment(),
            ])),
      ),
    );
  }
}
