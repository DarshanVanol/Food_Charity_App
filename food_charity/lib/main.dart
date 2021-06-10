import 'package:flutter/material.dart';
import 'package:food_charity/authenticate/logIn.dart';
import 'package:food_charity/pages/donator_home.dart';

import 'package:food_charity/pages/splace_screen.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/signin': (context) => LogIn(),
          '/donatehome': (context) => Donater_home(),
        },
        initialRoute: '/donatehome',
        home: Splace_Screen()),
  );
}
