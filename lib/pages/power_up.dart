import 'package:flutter/material.dart';
import 'package:timetable_2_flutter_admin/globals/myColors.dart';
import 'package:timetable_2_flutter_admin/globals/myFonts.dart';
import 'package:timetable_2_flutter_admin/globals/sizeConfig.dart';

class PowerUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String message = 'Powering up servers at CSE Department!';
    SizeConfig().init(context);
    double paddingWidth = 4.86 * SizeConfig.horizontalBlockSize;
    print(30 / MediaQuery.of(context).size.height);
    print(0.0439 * MediaQuery.of(context).size.height);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child:
                    Image.asset('assets/images/no_internet_illustration.png'),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: MyFonts.medium.setColor(kGrey).factor(4.39),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
