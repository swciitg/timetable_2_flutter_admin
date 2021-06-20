import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_flutter_admin/pages/homepage.dart';
import 'package:timetable_2_flutter_admin/pages/loginpage.dart';
import 'package:timetable_2_flutter_admin/pages/power_up.dart';
import 'package:timetable_2_flutter_admin/pages/splashpage.dart';
import 'package:timetable_2_flutter_admin/stores/authentication_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<AuthenticationStore>(
                create: (_) => AuthenticationStore(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Timetable Admin',
              initialRoute: '/',
              routes: {
                '/': (context) => SplashPage(),
                '/approval': (context) => HomePage(),
                '/login': (context) => LoginPage(),
                '/powerup': (context) => PowerUp(),
              },
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PowerUp(),
        );
      },
    );
  }
}
