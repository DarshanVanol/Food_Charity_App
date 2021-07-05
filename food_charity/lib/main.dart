import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:food_charity/Model/user.dart';
import 'package:food_charity/pages/splace_screen.dart';
import 'package:food_charity/services/auth.dart';
import 'package:food_charity/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthService auth = AuthService();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Column(
                children: [Text('Something Went Wrong')],
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<MyUser?>.value(
              catchError: (context, error) {},
              value: AuthService().userStream(),
              initialData: null,
              child: MaterialApp(
                  // routes: {'/form': (context) => Donate_form()},
                  // initialRoute: '/form',
                  debugShowCheckedModeBanner: false,
                  home: Splace_Screen()));
        }

        return MaterialApp(
          home: Scaffold(
            body: Column(
              children: [Text('Loading')],
            ),
          ),
        );
      },
    );
  }
}
