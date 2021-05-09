import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';
import 'package:timetable_2_flutter_admin/widgets/appBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(SizeConfig.screenHeight);
    print('Vertical Blocks = ${SizeConfig.verticalBlockSize}');
    print(40 / SizeConfig.verticalBlockSize);
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Text('Approval Page'),
      ),
    );
  }
}
