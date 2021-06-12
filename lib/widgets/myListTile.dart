import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';
import 'package:timetable_2_flutter_admin/globals/mySpaces.dart';
import 'package:timetable_2_flutter_admin/widgets/popUp.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';
import '../globals/myColors.dart';


// ignore: must_be_immutable
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

    switch (this.status) {
      case 'cancel':
        sideColor = kBlack;
        text = kRed;
        bgColor=lRed;
        break;
      case 'update':
        sideColor = kBlue;
        text = kYellow;
        bgColor=lYellow;
        break;
      default:
        sideColor = kBlue;
        bgColor=lBlue;
        text = kBlue;
    }
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
        // When the user taps the button, show a dialog box.
        onTap: () {
          showPopup(context, _popupBody( title, type , email), '$title $status');
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
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '$title',
                          style: MyFonts.extraBold.size(25),
                        ),
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
              Container(
                decoration: BoxDecoration(
                    color: bgColor,
                  borderRadius: BorderRadius.circular(18.25)
                ),
                height: 20,
                width: 79,

                child: SizedBox(

                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$status',
                      style:
                        MyFonts.medium.setColor(text).size(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      child: Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '$time',
                            style: MyFonts.extraBold.size(20),
                          ),
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

Widget _popupBody(String title,String type,String email) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(42.0),
          child: Row(
            children: [
               Padding(
                 padding: const EdgeInsets.fromLTRB(0.0,0.0,20,0.0),
                 child: Icon(Icons.school_outlined),
               ),
              Expanded(
                  child: Text('Course Code')),
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
                      padding: EdgeInsets.fromLTRB(30.0,10.0,.0,10),
                      child: Text(

                          '$title',
                        style: MyFonts.medium.size(20),

                      )
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,30.0),
          child: Container(
            height: 70,
            width: 360,
            decoration: BoxDecoration(
              gradient:
              LinearGradient(stops: [60,60.25], colors: [lBlue,lBlue]),
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
          padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,30.0),
          child: Row(
            children: [
               Padding(
                 padding: const EdgeInsets.fromLTRB(0.0,0.0,20,0.0),
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
          padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,30.0),
          child: Row(
            children: [
               Padding(
                 padding: const EdgeInsets.fromLTRB(0.0,0.0,20,0.0),
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
          padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,30.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,0.0,20,0.0),
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
             onPressed: (){},
             color: kBlue,
             textColor: Colors.white,
             ),
             Container(height: 20.0),//SizedBox(height: 20.0),
             ],
        ), 
      ],
    ),
  );
}


