import 'package:flutter/material.dart';
import 'package:food_charity/Model/user.dart';
import 'package:food_charity/authenticate/logIn.dart';
import 'package:food_charity/pages/choose.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print('$user this is user from wrapper');
    if (user == null) {
      return LogIn();
    } else {
      return Choose();
    }
  }
}
