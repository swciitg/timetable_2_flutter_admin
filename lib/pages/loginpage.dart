import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_flutter_admin/stores/authentication_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //double _paddingMultiplier = 0.0486;
  @override
  Widget build(BuildContext context) {
    double paddingWidth = 0.0486 * MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).size.width);
    return Consumer<AuthenticationStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/bg_triangle.png'),
                    fit: BoxFit.fill,
                  )),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 91,
                        child: SafeArea(
                          bottom: false,
                          top: true,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: paddingWidth),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Timetable',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 55,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Admin',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.yellow[600],
                                              fontSize: 55,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                      'assets/images/login_illustration.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.yellow[600],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            loginStore.signInWithMicrosoft(context);
                          },
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'LOGIN WITH OUTLOOK',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
