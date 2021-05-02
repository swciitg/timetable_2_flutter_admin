import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_flutter_admin/stores/authentication_store.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthenticationStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) {
      if (result) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/approval', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
