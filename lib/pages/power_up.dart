import 'package:flutter/material.dart';

class PowerUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(30 / MediaQuery.of(context).size.height);
    print(0.0439 * MediaQuery.of(context).size.height);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 0.0486 * MediaQuery.of(context).size.width),
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
                    'Powering up servers at CSE Department!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.grey[600],
                      fontSize: 0.0439 * MediaQuery.of(context).size.height,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
