import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: 'timetable',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 30),
              children: [
                TextSpan(
                    text: '.',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                        color: Colors.yellow,
                        fontSize: 40))
              ]),
        ),
      ),
      body: Center(
        child: Text('Approval Page'),
      ),
    );
  }
}
