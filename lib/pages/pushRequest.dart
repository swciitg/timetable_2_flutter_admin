import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';
import 'package:timetable_2_flutter_admin/globals/mySpaces.dart';
import 'package:timetable_2_flutter_admin/stores/prDatabase.dart';
import 'package:timetable_2_flutter_admin/widgets/myListTile.dart';

class PushRequest extends StatefulWidget {
  @override
  _PushRequestState createState() => _PushRequestState();
}

class _PushRequestState extends State<PushRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: MySpaces.horizontalScreenPadding),
        child: Provider(create: (_) => PRDatabase(), child: PushRequestList()),
      ),
    );
  }
}

class PushRequestList extends StatefulWidget {
  const PushRequestList({
    Key key,
  }) : super(key: key);

  @override
  _PushRequestListState createState() => _PushRequestListState();
}

class _PushRequestListState extends State<PushRequestList> {
  @override
  Widget build(BuildContext context) {
    print('Building');
    return StreamBuilder<List<List<Map<String, dynamic>>>>(
        initialData: null,
        stream: context.read<PRDatabase>().combinedStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<List<Map<String, dynamic>>>> snapshot) {
          if (snapshot.hasError) {
            return Text('There was an error.');
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<Widget> tiles = [];

          for (int i = 0; i < snapshot.data.length; i++) {
            snapshot.data.elementAt(i).forEach((element) {
              tiles.add(MyListTile(
                data: element,
              ));
            });
          }
          tiles.sort((a, b) =>
              (a as MyListTile).time.compareTo((b as MyListTile).time));
          DateTime header;
          for (int i = 0; i < tiles.length; i++) {
            if (header != (tiles[i] as MyListTile).time) {
              String heading =
                  DateFormat('d MMMM y').format((tiles[i] as MyListTile).time);
              print("Heading = $heading");
              header = (tiles[i] as MyListTile).time;
              tiles.insert(
                  i,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('$heading', style: MyFonts.extraBold.size(20)),
                  ));
            }
          }
          return ListView.separated(
            itemCount: tiles.length + 2,
            separatorBuilder: (context, _) => SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              if (index == 0 || index == (tiles.length + 1)) {
                return Container();
              }
              return tiles[index - 1];
            },
          );
        });
  }
}

List<Map<String, String>> testData = [
  {
    "title": "CS 101",
    "type": "Theory",
    "time": "8 am",
    "day": "Tuesday",
    "email": "gandhi18@iitg.ac.in",
    "status": "cancel"
  },
  {
    "title": "CS 223",
    "type": "Theory",
    "time": "9 am",
    "day": "Thursday",
    "email": "gandhi18@iitg.ac.in",
    "status": "cancel"
  },
  {
    "title": "CS 110",
    "type": "Assignment",
    "time": "12 am",
    "day": "Monday",
    "email": "gandhi18@iitg.ac.in",
    "status": "update"
  },
  {
    "title": "CS 245",
    "type": "Quiz",
    "time": "11 am",
    "day": "Friday",
    "email": "gandhi18@iitg.ac.in",
    "status": "update"
  },
  {
    "title": "HSS 123",
    "type": "Quiz",
    "time": "2 pm",
    "day": "Wednesday",
    "email": "gandhi18@iitg.ac.in",
    "status": "add"
  },
];
