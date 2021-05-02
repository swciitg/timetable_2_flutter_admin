import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_flutter_admin/stores/authentication_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        loginStore.signInWithMicrosoft(context);
                      },
                      child: Text('Sign in with Microsoft'),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
